cat > iot_simulator.py << 'EOF'
import json
import time
import random
from azure.iot.device import IoTHubDeviceClient, Message

CONNECTION_STRING = 'HostName=iothub-ogvd-labs.azure-devices.net;DeviceId=sensor-demo-01;SharedAccessKey=t0pyNMcKprqaZxWxGccm6sbPf9bZccelTbcFZSvG4yc='

try:
    client = IoTHubDeviceClient.create_from_connection_string(CONNECTION_STRING)
    client.connect()
    
    for i in range(30):
        temperature = round(random.uniform(5, 45), 2)
        humidity = round(random.uniform(20, 90), 2)
        pressure = round(random.uniform(990, 1030), 2)
        
        sensor_data = {
            'deviceId': 'sensor-demo-01',
            'temperature': temperature,
            'humidity': humidity,
            'pressure': pressure,
            'timestamp': time.strftime('%Y-%m-%dT%H:%M:%SZ'),
            'location': 'Madrid, ES'
        }
        
        message = Message(json.dumps(sensor_data))
        message.content_type = 'application/json'
        message.content_encoding = 'utf-8'
        
        client.send_message(message)
        print(f'Enviado: T={temperature}°C H={humidity}% P={pressure}hPa')
        time.sleep(3)
    
    client.disconnect()
    
except Exception as e:
    print(f'Error: {e}')
EOF

python3 iot_simulator.py