# any import? 
import librosa

def compute_beats(y, sr):
    # your code here
    tempo, beats = librosa.beat.beat_track(y, sr, units='samples')
    return beats

def add_samples(y, sample, beats):
    y_out=y.copy()
    # your code here ...
    for i in beats:
        y_out[i:i+len(sample)] += sample
    
    return y_out

