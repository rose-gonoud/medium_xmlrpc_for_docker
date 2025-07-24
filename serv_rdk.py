import xmlrpc.server as xmlrpc_server
from xmlrpc.server import SimpleXMLRPCRequestHandler
from xmlrpc.server import SimpleXMLRPCServer
from rdkit import Chem
from rdkit.Chem import Descriptors
import pandas as pd
from io import BytesIO
 
def calc_mols(arg):
    smiles_lst = arg.data.decode().split("\n")
    res = []
    for smi in smiles_lst:
        mol = Chem.MolFromSmiles(smi)
        desc = Descriptors.CalcMolDescriptors(mol)
        desc['SMILES'] = smi
        res.append(desc)
    df = pd.DataFrame(res)
    bio = BytesIO()
    df.to_csv(bio, index=False)
    bio.flush()
    bio.seek(0)
    return bio.getvalue()
 
server = xmlrpc_server.SimpleXMLRPCServer(('localhost', 8080))
server.register_function(calc_mols)
server.serve_forever()