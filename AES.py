#!/usr/bin/env python3
# AES 256 encryption/decryption using pycryptodome library

import sys
from base64 import b64encode, b64decode
import hashlib
from Cryptodome.Cipher import AES
import os
import ast
from Cryptodome.Random import get_random_bytes
import json

# Encrypting Function Takes The Data Collected From Files Into String Variable And Generates A Hash Using The Password Provided By The Attacker For Better Encryption

def encrypt(plain_text, password):    
    salt = get_random_bytes(AES.block_size)
    private_key = hashlib.scrypt(
        password.encode(), salt=salt, n=2**14, r=8, p=1, dklen=32)
    cipher_config = AES.new(private_key, AES.MODE_GCM)
    cipher_text, tag = cipher_config.encrypt_and_digest(bytes(plain_text, 'utf-8'))
    return {
        'cipher_text': b64encode(cipher_text).decode('utf-8'),
        'salt': b64encode(salt).decode('utf-8'),
        'nonce': b64encode(cipher_config.nonce).decode('utf-8'),
        'tag': b64encode(tag).decode('utf-8')
    }

# Decrypting Function Takes The AES Dict Encryption From File And Decrypts With The Same Password Used In Encryption For Better Anti-Security

def decrypt(enc_dict, password):
    salt = b64decode(enc_dict['salt'])
    cipher_text = b64decode(enc_dict['cipher_text'])
    nonce = b64decode(enc_dict['nonce'])
    tag = b64decode(enc_dict['tag'])
    private_key = hashlib.scrypt(
        password.encode(), salt=salt, n=2**14, r=8, p=1, dklen=32)
    cipher = AES.new(private_key, AES.MODE_GCM, nonce=nonce)
    decrypted = cipher.decrypt_and_verify(cipher_text, tag)
    return decrypted

def main():
    password = sys.argv[1]
    hexoencfile = sys.argv[2]
    encmode = sys.argv[3]
    if encmode == "1":
        f = open(hexoencfile, "r")
        hexdata = f.read()
        encrypted = encrypt(hexdata, password)
        f.close()
        f = open(hexoencfile, "w")
        f.write(json.dumps(encrypted))
        f.close()
    elif encmode == "2":
        f = open(hexoencfile, "r")
        encdata = f.read()
        encrypted = eval(encdata)
        decrypted = decrypt(encrypted, password)
        f.close()
        f = open("DD", "w")
        f.write(bytes.decode(decrypted))
        f.close()
main()
