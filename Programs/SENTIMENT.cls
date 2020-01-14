/// 001 Sentiment Analysis
Class CONVERGENCE.WEB.SENTIMENT Extends (Ens.BusinessProcessBPL, isc.py.ens.ProcessUtils)
{

Storage Default
{
<Type>%Storage.Persistent</Type>
}

/// BPL Definition
XData BPL [ XMLNamespace = "http://www.intersystems.com/bpl" ]
{
<process language='objectscript' request='Ens.Request' response='Ens.Response' component='1' height='2000' width='2000' >
<sequence xend='200' yend='1500' >
<call name='Import Python Libraries' target='isc.py.ens.Operation' async='0' xpos='200' ypos='250' >
<annotation><![CDATA[import matplotlib
import matplotlib.pyplot as plt
import pandas as pd
import numpy as np
import re
from sklearn.model_selection import train_test_split
import logging
import multiprocessing
import gensim
from gensim.models import Word2Vec
import tensorflow as tf
from tensorflow import keras]]></annotation>
<request type='isc.py.msg.ExecutionRequest' >
<assign property="callrequest.Code" value="process.GetAnnotation(&quot;Import Python Libraries&quot;)" action="set" />
</request>
<response type='isc.py.msg.ExecutionResponse' />
</call>
<flow xpos='200' ypos='350' xend='200' yend='600' >
<sequence >
<call name='Query In Negative Tweets' target='isc.py.ens.Operation' async='0' xpos='200' ypos='500' >
<annotation><![CDATA[SELECT * FROM User_WEB.SENTIMENT_NEG]]></annotation>
<request type='isc.py.msg.QueryRequest' >
<assign property="callrequest.Query" value="process.GetAnnotation(&quot;Query In Negative Tweets&quot;)" action="set" />
<assign property="callrequest.Variable" value="&quot;data_negative&quot;" action="set" />
<assign property="callrequest.Type" value="&quot;dataframe&quot;" action="set" />
</request>
<response type='Ens.Response' />
</call>
</sequence>
<sequence >
<call name='Query In Positive Tweets' target='isc.py.ens.Operation' async='0' xpos='470' ypos='500' >
<annotation><![CDATA[SELECT * FROM User_WEB.SENTIMENT_POS]]></annotation>
<request type='isc.py.msg.QueryRequest' >
<assign property="callrequest.Query" value="process.GetAnnotation(&quot;Query In Positive Tweets&quot;)" action="set" />
<assign property="callrequest.Variable" value="&quot;data_positive&quot;" action="set" />
<assign property="callrequest.Type" value="&quot;dataframe&quot;" action="set" />
</request>
<response type='Ens.Response' />
</call>
</sequence>
<sequence >
<call name='Query In Unknown Tweets' target='isc.py.ens.Operation' async='0' xpos='740' ypos='500' >
<annotation><![CDATA[SELECT * FROM User_WEB.SENTIMENT_UNK]]></annotation>
<request type='isc.py.msg.QueryRequest' >
<assign property="callrequest.Query" value="process.GetAnnotation(&quot;Query In Unknown Tweets&quot;)" action="set" />
<assign property="callrequest.Variable" value="&quot;data_unknown&quot;" action="set" />
<assign property="callrequest.Type" value="&quot;dataframe&quot;" action="set" />
</request>
<response type='Ens.Response' />
</call>
</sequence>
</flow>
<call name='Preprocess &amp; Split' target='isc.py.ens.Operation' async='0' xpos='200' ypos='700' >
<annotation><![CDATA[sample_size = min(data_positive.shape[0], data_negative.shape[0])
raw_data = np.concatenate((data_positive['ttext'].values[:sample_size],data_negative['ttext'].values[:sample_size]), axis=0)
labels = [1] * sample_size + [0] * sample_size
def preprocess_text(text):
    text = text.lower().replace("ё", "е")
    text = re.sub('((www\.[^\s]+)|(https?://[^\s]+))', 'URL', text)
    text = re.sub('@[^\s]+', 'USER', text)
    text = re.sub('[^a-zA-Zа-яА-Я1-9]+', ' ', text)
    text = re.sub(' +', ' ', text)
    return text.strip()
data = [preprocess_text(t) for t in raw_data]
x_train, x_test, y_train, y_test = train_test_split(data, labels, test_size=0.2, random_state=1)
new_data = data_unknown['ttext'].values[:sample_size]
info = [preprocess_text(t) for t in new_data]]]></annotation>
<request type='isc.py.msg.ExecutionRequest' >
<assign property="callrequest.Code" value="process.GetAnnotation(&quot;Preprocess &amp; Split&quot;)" action="set" />
<assign property="callrequest.SeparateLines" value="0" action="set" />
</request>
<response type='isc.py.msg.ExecutionResponse' />
</call>
<call name='Define Loss Metrics' target='isc.py.ens.Operation' async='0' xpos='200' ypos='800' >
<annotation><![CDATA[def precision(y_true, y_pred):
    true_positives = keras.backend.sum(keras.backend.round(keras.backend.clip(y_true * y_pred, 0, 1)))
    predicted_positives = keras.backend.sum(keras.backend.round(keras.backend.clip(y_pred, 0, 1)))
    precision = true_positives / (predicted_positives + keras.backend.epsilon())
    return precision
def recall(y_true, y_pred):
    true_positives = keras.backend.sum(keras.backend.round(keras.backend.clip(y_true * y_pred, 0, 1)))
    possible_positives = keras.backend.sum(keras.backend.round(keras.backend.clip(y_true, 0, 1)))
    recall = true_positives / (possible_positives + keras.backend.epsilon())
    return recall
def f1(y_true, y_pred):
    def recall(y_true, y_pred):
        true_positives = keras.backend.sum(keras.backend.round(keras.backend.clip(y_true * y_pred, 0, 1)))
        possible_positives = keras.backend.sum(keras.backend.round(keras.backend.clip(y_true, 0, 1)))
        recall = true_positives / (possible_positives + keras.backend.epsilon())
        return recall
    def precision(y_true, y_pred):
        true_positives = keras.backend.sum(keras.backend.round(keras.backend.clip(y_true * y_pred, 0, 1)))
        predicted_positives = keras.backend.sum(keras.backend.round(keras.backend.clip(y_pred, 0, 1)))
        precision = true_positives / (predicted_positives + keras.backend.epsilon())
        return precision
    precision = precision(y_true, y_pred)
    recall = recall(y_true, y_pred)
    f1 = 2 * ((precision * recall) / (precision + recall + keras.backend.epsilon()))
    return f1]]></annotation>
<request type='isc.py.msg.ExecutionRequest' >
<assign property="callrequest.Code" value="process.GetAnnotation(&quot;Define Loss Metrics&quot;)" action="set" />
<assign property="callrequest.SeparateLines" value="0" action="set" />
</request>
<response type='isc.py.msg.ExecutionResponse' />
</call>
<call name='Unknown Tweets to File' target='isc.py.ens.Operation' async='0' xpos='200' ypos='900' >
<annotation><![CDATA[with open('D:/InterSystems/IRIS/CSP/convergence/SENTIMENT001.txt', 'w', encoding='utf-8') as f:
    for t in data_unknown['ttext']:
        tweet = preprocess_text(t)
        print(tweet, file=f)]]></annotation>
<request type='isc.py.msg.ExecutionRequest' >
<assign property="callrequest.Code" value="process.GetAnnotation(&quot;Unknown Tweets to File&quot;)" action="set" />
<assign property="callrequest.SeparateLines" value="0" action="set" />
</request>
<response type='isc.py.msg.ExecutionResponse' />
</call>
<call name='Train W2V Model' target='isc.py.ens.Operation' async='0' xpos='200' ypos='1000' >
<annotation><![CDATA[logging.basicConfig(format='%(asctime)s : %(levelname)s : %(message)s', level=logging.INFO)
data = gensim.models.word2vec.LineSentence('D:/InterSystems/IRIS/CSP/convergence/SENTIMENT001.txt')
model = Word2Vec(data, size=200, window=5, min_count=3, workers=multiprocessing.cpu_count())
model.save('D:/InterSystems/IRIS/CSP/convergence/SENTIMENT002.w2v')]]></annotation>
<request type='isc.py.msg.ExecutionRequest' >
<assign property="callrequest.Code" value="process.GetAnnotation(&quot;Train W2V Model&quot;)" action="set" />
</request>
<response type='isc.py.msg.ExecutionResponse' />
</call>
<call name='Prepare CNN Model' target='isc.py.ens.Operation' async='0' xpos='200' ypos='1100' >
<annotation><![CDATA[SENTENCE_LENGTH = 26
NUM = 100000
def get_sequences(tokenizer, x):
    sequences = tokenizer.texts_to_sequences(x)
    return keras.preprocessing.sequence.pad_sequences(sequences, maxlen=SENTENCE_LENGTH)
tokenizer = keras.preprocessing.text.Tokenizer(num_words=NUM)
tokenizer.fit_on_texts(x_train)
x_train_seq = get_sequences(tokenizer, x_train)
x_test_seq = get_sequences(tokenizer, x_test)
info_seq = get_sequences(tokenizer, info)
w2v_model = Word2Vec.load('D:/InterSystems/IRIS/CSP/convergence/SENTIMENT002.w2v')
DIM = w2v_model.vector_size 
embedding_matrix = np.zeros((NUM, DIM))
for word, i in tokenizer.word_index.items():
    if i >= NUM:
        break
    if word in w2v_model.wv.vocab.keys():
        embedding_matrix[i] = w2v_model.wv[word]
tweet_input = keras.layers.Input(shape=(SENTENCE_LENGTH,), dtype='int32')
tweet_encoder = keras.layers.Embedding(NUM, DIM, input_length=SENTENCE_LENGTH, weights=[embedding_matrix], trainable=False)(tweet_input)
branches = []
x = keras.layers.Dropout(0.2)(tweet_encoder)
for size, filters_count in [(2, 10), (3, 10), (4, 10), (5, 10)]:
    for i in range(filters_count):
        branch = keras.layers.Conv1D(filters=1, kernel_size=size, padding='valid', activation='relu')(x)
        branch = keras.layers.GlobalMaxPooling1D()(branch)
        branches.append(branch)
x = keras.layers.concatenate(branches, axis=1)
x = keras.layers.Dropout(0.2)(x)
x = keras.layers.Dense(30, activation='relu')(x)
x = keras.layers.Dense(1)(x)
output = keras.layers.Activation('sigmoid')(x)]]></annotation>
<request type='isc.py.msg.ExecutionRequest' >
<assign property="callrequest.Code" value="process.GetAnnotation(&quot;Prepare CNN Model&quot;)" action="set" />
<assign property="callrequest.SeparateLines" value="0" action="set" />
</request>
<response type='isc.py.msg.ExecutionResponse' />
</call>
<call name='Train CNN Model' target='isc.py.ens.Operation' async='0' xpos='200' ypos='1200' >
<annotation><![CDATA[orig_stdout = sys.stdout
f = open('D:/InterSystems/IRIS/CSP/convergence/SENTIMENT004.txt', 'w')
sys.stdout = f
model_cnn = keras.models.Model(inputs=[tweet_input], outputs=[output])
model_cnn.compile(loss='binary_crossentropy', optimizer='adam', metrics=[precision, recall, f1])
model_cnn.summary()
checkpoint = keras.callbacks.ModelCheckpoint('D:/InterSystems/IRIS/CSP/convergence/SENTIMENT003-CNN-FROZEN-EMBEDDINGS-{epoch:02d}-{val_f1:.2f}.hdf5', monitor='val_f1', save_best_only=True, mode='max', period=1)
history = model_cnn.fit(x_train_seq, y_train, batch_size=32, epochs=10, validation_split=0.25, callbacks = [checkpoint])
sys.stdout = orig_stdout
f.close()]]></annotation>
<request type='isc.py.msg.ExecutionRequest' >
<assign property="callrequest.Code" value="process.GetAnnotation(&quot;Train CNN Model&quot;)" action="set" />
</request>
<response type='isc.py.msg.ExecutionResponse' />
</call>
<call name='Visualize Loss Metrics' target='isc.py.ens.Operation' async='0' xpos='200' ypos='1300' >
<annotation><![CDATA[plt.style.use('ggplot')
fig, axes = plt.subplots(ncols=2, nrows=2, figsize=(16, 9))
ax1, ax2, ax3, ax4 = axes.ravel()
ax1.plot(range(1, len(history.history['precision']) + 1), history.history['precision'], label='Training')
ax1.plot(range(1, len(history.history['val_precision']) + 1), history.history['val_precision'], label='Validation')
ax1.set_ylabel('Precision')
ax1.set_xlabel('Epoch')
ax1.legend()
ax1.margins(0)
ax2.plot(range(1, len(history.history['recall']) + 1), history.history['recall'], label='Training')
ax2.plot(range(1, len(history.history['val_recall']) + 1), history.history['val_recall'], label='Validation')
ax2.set_ylabel('Recall')
ax2.set_xlabel('Epoch')
ax2.legend()
ax2.margins(0)
ax3.plot(range(1, len(history.history['f1']) + 1), history.history['f1'], label='Training')
ax3.plot(range(1, len(history.history['val_f1']) + 1), history.history['val_f1'], label='Validation')
ax3.set_ylabel("$F_1$")
ax3.set_xlabel('Epoch')
ax3.legend()
ax3.margins(0)
ax4.plot(range(1, len(history.history['loss']) + 1), history.history['loss'], label='Training')
ax4.plot(range(1, len(history.history['val_loss']) + 1), history.history['val_loss'], label='Validation')
ax4.set_ylabel('Loss')
ax4.set_xlabel('Epoch')
ax4.legend()
ax4.margins(0)
plt.savefig('D:/InterSystems/IRIS/CSP/convergence/SENTIMENT005.png', format='png', dpi=300)]]></annotation>
<request type='isc.py.msg.ExecutionRequest' >
<assign property="callrequest.Code" value="process.GetAnnotation(&quot;Visualize Loss Metrics&quot;)" action="set" />
<assign property="callrequest.SeparateLines" value="0" action="set" />
</request>
<response type='isc.py.msg.ExecutionResponse' />
</call>
<call name='Predict Sentiment' target='isc.py.ens.Operation' async='0' xpos='200' ypos='1400' >
<annotation><![CDATA[classes=model_cnn.predict(info_seq)
classes=pd.DataFrame(classes)
info=pd.DataFrame(info)
prediction=pd.concat([info, classes], axis=1)
f = open('D:/InterSystems/IRIS/CSP/convergence/SENTIMENT006.txt', 'w', encoding="utf-8")
sys.stdout = f
print(prediction)
sys.stdout = orig_stdout
f.close()]]></annotation>
<request type='isc.py.msg.ExecutionRequest' >
<assign property="callrequest.Code" value="process.GetAnnotation(&quot;Predict Sentiment&quot;)" action="set" />
<assign property="callrequest.SeparateLines" value="0" action="set" />
</request>
<response type='isc.py.msg.ExecutionResponse' />
</call>
</sequence>
</process>
}

}
