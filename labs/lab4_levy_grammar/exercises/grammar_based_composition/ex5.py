# %% Import libraries
import os
os.chdir(os.path.dirname(os.path.abspath(__file__)))
from classes import Composer, Grammar_Sequence

# %%

upbeat_grammar={ 
    "S":["M", "SM"],
    "M": ["HH"],    
    "H": ["h", "QQ", "$h", "ththth", "phphph"],
    "Q": ["q", "oo", "$q", "tqtqtq", "pqpqpq"],
    "O": ["o", "$o", "tototo", "popopo"]
}


upbeat_word_dur={
    "h":0.5, # half-measure
    "o":1/8, # octave-measure
    "q":0.25, # quarter-measure
    # your code here for $h, $q, $o, th, tq, to
    "$h": 1/2,
    "$q": 1/4,
    "$o": 1/8,
    "th": 1/3,
    "tq": 1/6,
    "to": 1/12,
              "ph": 1/3,
          "pq": 1/6,
          "po": 1/12,
}


if __name__=="__main__":
    fn_out="upbeat_composition.wav"

    NUM_M=8
    START_SEQUENCE="M"*NUM_M
    G=Grammar_Sequence(upbeat_grammar)        
        
    seqs=G.create_sequence(START_SEQUENCE)
    print("\n".join(seqs), "\nFinal sequence: ", G.sequence)    
    C= Composer("sounds/cymb.wav", upbeat_word_dur)
    C.create_sequence(G.sequence)
    C.write("out/"+fn_out)
    