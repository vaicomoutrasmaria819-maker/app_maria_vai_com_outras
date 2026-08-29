#!/usr/bin/env python3
"""
Script para criar usuários de teste no Firebase Authentication e Firestore.
Uso: python scripts/create_test_users.py service-account.json
"""

import firebase_admin
from firebase_admin import credentials, auth, firestore
import sys
import json

def create_test_user(db, email, password, name, phone, role, gender=None):
    """Cria um usuário no Firebase Authentication e documento no Firestore."""
    try:
        # Criar usuário no Authentication
        user = auth.create_user(
            email=email,
            password=password,
            display_name=name
        )
        
        # Criar documento no Firestore
        user_data = {
            'name': name,
            'email': email,
            'phone': phone,
            'role': role,
            'photoUrl': None,
            'isActive': True,
            'createdAt': firestore.SERVER_TIMESTAMP
        }
        
        if gender:
            user_data['gender'] = gender
        
        db.collection('users').document(user.uid).set(user_data)
        
        print(f"✅ Usuário criado: {email}")
        print(f"   Nome: {name}")
        print(f"   Papel: {role}")
        print(f"   UID: {user.uid}")
        print()
        return user.uid
        
    except Exception as e:
        print(f"❌ Erro ao criar usuário {email}: {e}")
        return None

def main():
    if len(sys.argv) < 2:
        print("Uso: python create_test_users.py <service-account.json>")
        print("Obtenha a service account em: Firebase Console → Project Settings → Service Accounts")
        sys.exit(1)
    
    service_account_path = sys.argv[1]
    
    try:
        # Inicializar Firebase Admin SDK
        cred = credentials.Certificate(service_account_path)
        firebase_admin.initialize_app(cred)
        
        db = firestore.client()
        
        print("🔥 Criando usuários de teste no Firebase...")
        print("=" * 50)
        print()
        
        # Criar usuários de teste
        users = [
            {
                'email': 'cliente@teste.com',
                'password': 'cliente123',
                'name': 'Maria Silva',
                'phone': '(11) 99999-1001',
                'role': 'client',
                'gender': None
            },
            {
                'email': 'prestadora@teste.com',
                'password': 'prestadora123',
                'name': 'Ana Costa',
                'phone': '(11) 99999-1002',
                'role': 'provider',
                'gender': 'female'
            },
            {
                'email': 'prestadora2@teste.com',
                'password': 'prestadora123',
                'name': 'Juliana Santos',
                'phone': '(11) 99999-1004',
                'role': 'provider',
                'gender': 'female'
            },
            {
                'email': 'admin@teste.com',
                'password': 'admin123',
                'name': 'Administrador',
                'phone': '(11) 99999-1003',
                'role': 'admin',
                'gender': None
            }
        ]
        
        created_count = 0
        for user_data in users:
            uid = create_test_user(
                db=db,
                email=user_data['email'],
                password=user_data['password'],
                name=user_data['name'],
                phone=user_data['phone'],
                role=user_data['role'],
                gender=user_data['gender']
            )
            if uid:
                created_count += 1
        
        print("=" * 50)
        print(f"✅ {created_count} usuários de teste criados com sucesso!")
        print()
        print("📱 Credenciais de Login:")
        print("👤 Cliente: cliente@teste.com / cliente123")
        print("👩 Prestadora: prestadora@teste.com / prestadora123")
        print("👩 Prestadora 2: prestadora2@teste.com / prestadora123")
        print("👨‍💼 Admin: admin@teste.com / admin123")
        print("🔑 Código Admin: MARIAVAI-ADMIN-2026")
        
    except Exception as e:
        print(f"❌ Erro: {e}")
        sys.exit(1)

if __name__ == "__main__":
    main()