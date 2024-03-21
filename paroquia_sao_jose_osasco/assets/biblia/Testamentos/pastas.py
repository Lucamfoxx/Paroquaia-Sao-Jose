import os

def listar_pastas_no_mesmo_nivel():
    # Obtém o diretório atual onde o script está localizado
    diretorio_atual = os.path.dirname(os.path.abspath(__file__))
    
    # Lista todos os itens (arquivos e diretórios) no diretório atual
    itens = os.listdir(diretorio_atual)
    
    # Filtra apenas os diretórios
    pastas = [item for item in itens if os.path.isdir(os.path.join(diretorio_atual, item))]
    
    # Retorna a lista de nomes das pastas
    return pastas

def salvar_em_txt(nomes, nome_arquivo):
    with open(nome_arquivo, 'w') as arquivo:
        for nome in nomes:
            arquivo.write(nome + '\n')

if __name__ == "__main__":
    pastas = listar_pastas_no_mesmo_nivel()
    print("Pastas no mesmo nível do script:")
    for pasta in pastas:
        print(pasta)
    
    # Salvar os nomes das pastas em um arquivo txt
    nome_arquivo = 'pastas.txt'
    salvar_em_txt(pastas, nome_arquivo)
    print(f"Os nomes das pastas foram salvos no arquivo '{nome_arquivo}'.")
