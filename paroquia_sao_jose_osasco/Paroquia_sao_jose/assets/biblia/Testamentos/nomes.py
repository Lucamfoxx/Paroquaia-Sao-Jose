import os

# Diretório onde o script está localizado
diretorio_atual = os.path.dirname(os.path.abspath(__file__))

# Lista para armazenar os nomes dos arquivos encontrados
nomes_arquivos = []

# Percorre todos os arquivos no diretório atual
for nome_arquivo in os.listdir(diretorio_atual):
    # Verifica se o arquivo é um arquivo de texto
    if nome_arquivo.endswith(".txt"):
        nomes_arquivos.append(nome_arquivo)

# Caminho do arquivo onde os nomes dos arquivos serão salvos
caminho_arquivo_saida = os.path.join(diretorio_atual, "nomes_arquivos_encontrados.txt")

# Escreve os nomes dos arquivos encontrados em um arquivo de saída
with open(caminho_arquivo_saida, "w") as arquivo_saida:
    for nome_arquivo in nomes_arquivos:
        arquivo_saida.write(nome_arquivo + "\n")

print("Nomes dos arquivos encontrados foram salvos em 'nomes_arquivos_encontrados.txt'")
