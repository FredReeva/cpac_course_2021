import numpy as np

def sort_songs(audio_features):
    """"Receive audio features and sort them according to your criterion"

    Args:
        audio_features (list of dictionaries): List of songs with audio features

    Returns:
        list of dict: the sorted list
    """
    sorted_songs=[]
    dance = []
    for song in audio_features:
        dance.append(song['danceability'])
    sorted_idxs = np.argsort(dance)
    indices1 = list(sorted_idxs[0::2])
    indices2 = list(sorted_idxs[1::2])
    indices = np.append(indices1, indices2[::-1])

    for idx in indices:
        sorted_songs.append(audio_features[idx])
        
    return sorted_songs