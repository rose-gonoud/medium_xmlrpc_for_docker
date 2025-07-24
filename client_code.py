import xmlrpc.client as xmlrpc_client
from xmlrpc.client import Binary
import sys
 
client = xmlrpc_client.ServerProxy('http://localhost:8080')
 
def calc_descs(inpath, outpath):
    with open(inpath, 'rb') as handle:
        binary_data = Binary(handle.read())
        bio = client.calc_mols(binary_data)
        with open(outpath, 'wb') as outf:
            outf.write(bio.data)
 
if __name__=="__main__":
    calc_descs(sys.argv[1], sys.argv[2])
