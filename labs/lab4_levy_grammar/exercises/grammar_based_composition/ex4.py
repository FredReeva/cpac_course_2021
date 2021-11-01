# %% Import libraries
import os
os.chdir(os.path.dirname(os.path.abspath(__file__)))
from classes import Composer, Grammar_Sequence

# %%

slow_grammar={
    #your code here
    "S":["M", "SM"],
    "M": ["HH", "w", "$w"],    
    "H": ["h", "$h", "ththth"],

    # your code here
}

slow_word_dur= {
    # your code here 
    "w": 1,
    "h":0.5, # half-measure
    "$w": 1,
    "$h": 1/2,
    "$q": 1/4,   
    "th": 1/3,   
}



if __name__=="__main__":
    fn_out="slow_composition.wav"

    NUM_M=8
    START_SEQUENCE="M"*NUM_M
    G=Grammar_Sequence(slow_grammar)        
        
    seqs=G.create_sequence(START_SEQUENCE)
    print("\n".join(seqs), "\nFinal sequence: ", G.sequence)    
    C= Composer("sounds/kick.wav", slow_word_dur)
    C.create_sequence(G.sequence)
    C.write("out/"+fn_out)
    
# %%
