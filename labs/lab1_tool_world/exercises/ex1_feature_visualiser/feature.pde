import ddf.minim.*;
import ddf.minim.analysis.*;
final float EPS = 0.000000001;

float spectral_sum(FFT fft, int K){
  float sum = 0;
  for(int k=0; k<K; k++){
    sum += fft.getBand(k);
  }
  return sum;
}

float compute_flatness(FFT fft, int K){
  float flatness = 0;
  float prod = 0;
  for(int k=0; k<K; k++){
    prod *= fft.getBand(k);
  }
  flatness = K*pow(prod, 1/K)/(spectral_sum(fft, K)+EPS);
  return flatness;
}

float compute_centroid(FFT fft, int K, float[] freqs){
  float centroid = 0;
  float sum = 0;
  for(int k=0; k<K; k++){
    sum += freqs[k]*fft.getBand(k);
  }
  centroid = sum/(spectral_sum(fft, K)+EPS);
  return centroid;
}

float compute_spread(FFT fft, int K, float[] freqs, float centroid){
  float spread = 0;
  float sum = 0;
  for(int k=0; k<K; k++){
    sum += pow(freqs[k]-centroid, 2)*fft.getBand(k);
  }
  spread = sqrt(sum/(spectral_sum(fft, K)+EPS)); // why 'sqrt'?
  return spread;
}

float compute_skewness(FFT fft, int K, float[] freqs, float centroid, float spread){
  float skewness = 0;
  float sum = 0;

  for(int k=0; k<K; k++){
    sum += pow(freqs[k]-centroid, 3)*fft.getBand(k);
  }

  skewness = sum/(K*pow(spread, 3)+EPS);
  return skewness;
}

float compute_entropy(FFT fft, int K){
  float entropy = 0;
  float sum = 0;
  
  for(int k=0; k<K; k++){
    sum += fft.getBand(k)*log(fft.getBand(k)+EPS);
  }

  entropy = sum/(log(K)+EPS); // missing '-'?
  return entropy;
}

float compute_energy() {    
  return random(0);
}
class AgentFeature { 
  float sampleRate;
  int K;
  FFT fft;
  BeatDetect beat;
  
  float[] freqs;
  float sum_of_bands;
  float centroid;
  float spread;
  float energy;
  float skewness;
  float entropy;
  float flatness;
  boolean isBeat;
  float lambda_smooth;
  AgentFeature(int bufferSize, float sampleRate){    
    this.fft = new FFT(bufferSize, sampleRate);
    this.fft.window(FFT.HAMMING);
    this.K=this.fft.specSize();
    this.beat = new BeatDetect();
    
    this.lambda_smooth = 0.1;
    this.freqs=new float[this.K];
    for(int k=0; k<this.K; k++){
      this.freqs[k]= (0.5*k/this.K)*sampleRate;
    }
    
    this.isBeat=false;
    this.centroid=0;
    this.spread=0;
    this.sum_of_bands = 0;
    this.skewness=0;    
    this.entropy=0;
    this.energy=0;
  }
  float smooth_filter(float old_value, float new_value){
    /* Try to implement a smoothing filter using this.lambda_smooth*/
    return this.lambda_smooth*new_value+(1-this.lambda_smooth)*old_value;
  }
  void reasoning(AudioBuffer mix){
     this.fft.forward(mix);
     this.beat.detect(mix);
     float centroid = compute_centroid(this.fft, this.K, this.freqs);
     float flatness = compute_flatness(this.fft, this.K);
     float spread = compute_spread(this.fft, this.K, this.freqs, this.centroid);                                  
     float skewness= compute_skewness(this.fft, this.K, this.freqs, this.centroid, this.spread);
     float entropy = compute_entropy(this.fft, this.K);     
     float energy = compute_energy();
     
     this.centroid = centroid;    
     this.energy = energy;
     this.flatness = flatness;
     this.spread = spread;
     this.skewness = skewness;
     this.entropy = entropy;  }   
} 
