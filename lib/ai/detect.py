import json
import random
import time
import joblib
import numpy as np
from sklearn.ensemble import IsolationForest

# ====== 파일 접근 로그 데이터 시뮬레이션 ======
def generate_log():
    """
    랜덤 파일 접근 로그 생성 (정상/비정상)
    """
    logs = []
    for _ in range(200):  # 정상 패턴 데이터 생성
        logs.append({
            "user": random.choice(["user1", "user2", "user3"]),
            "file_size_MB": random.uniform(1, 50),  # 정상적인 파일 크기 (1~50MB)
            "transfer_type": random.choice(["internal", "internal", "internal", "external"]),  # 내부 전송이 많음
            "device": random.choice(["work_PC", "work_PC", "USB"]),  # USB 사용 빈도 낮음
            "time": random.choice(range(8, 18))  # 근무시간 (8~18시)
        })
    
    for _ in range(20):  # 비정상 패턴 데이터 추가 (10% 정도)
        logs.append({
            "user": random.choice(["user1", "user2", "user3"]),
            "file_size_MB": random.uniform(100, 500),  # 대용량 파일
            "transfer_type": "external",  # 외부로 파일 전송
            "device": random.choice(["USB", "email"]),  # USB 또는 이메일 사용
            "time": random.choice(range(0, 24))  # 시간 무작위 (근무 외 시간 포함)
        })
    
    return logs

# ====== 데이터 전처리 ======
def preprocess_logs(logs):
    """
    로그 데이터를 AI 모델이 학습할 수 있도록 변환
    """
    X = []
    for log in logs:
        X.append([
            log["file_size_MB"],  # 파일 크기
            1 if log["transfer_type"] == "external" else 0,  # 외부 전송 여부
            1 if log["device"] == "USB" else 0,  # USB 사용 여부
            1 if log["device"] == "email" else 0,  # 이메일 사용 여부
            log["time"]  # 접근 시간
        ])
    return np.array(X)

# ====== AI 모델 학습 ======
def train_model():
    logs = generate_log()
    X = preprocess_logs(logs)
    
    model = IsolationForest(n_estimators=100, contamination=0.1)  # 비정상 패턴 10%로 설정
    model.fit(X)
    
    joblib.dump(model, "ai_security_model.pkl")  # 모델 저장
    print("✅ AI 모델 학습 완료")

# ====== 실시간 이상 탐지 ======
def detect_anomalies(new_log):
    model = joblib.load("ai_security_model.pkl")  # 저장된 모델 불러오기
    X_new = preprocess_logs([new_log])
    prediction = model.predict(X_new)[0]  # -1이면 비정상, 1이면 정상
    
    if prediction == -1:
        print(f"🚨 [경고] 비정상적인 파일 접근 감지! → {new_log}")
    else:
        print(f"✅ 정상적인 접근: {new_log}")

# ====== 실행 ======
if __name__ == "__main__":
    train_model()  # AI 모델 학습
    
    # 실시간 감지 테스트
    test_logs = [
        {"user": "user4", "file_size_MB": 250, "transfer_type": "external", "device": "USB", "time": 2},  # 비정상
        {"user": "user1", "file_size_MB": 5, "transfer_type": "internal", "device": "work_PC", "time": 10}  # 정상
    ]
    
    for log in test_logs:
        detect_anomalies(log)
        time.sleep(1)
