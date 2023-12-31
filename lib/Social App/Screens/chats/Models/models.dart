class ModelsModel {
  String? id;
  int? created;
  String? root;

  ModelsModel(
      {this.id,
        this.created,
        this.root,
        });

  ModelsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    created = json['created'];
    root = json['root'];

  }

  static List<ModelsModel>modelsFormSnapshot (List modelSnapshot){
  return modelSnapshot.map((data) =>ModelsModel.fromJson(data)).toList();
  }
}


//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['object'] = this.object;
//     data['created'] = this.created;
//     data['model'] = this.model;
//     if (this.choices != null) {
//       data['choices'] = this.choices!.map((v) => v.toJson()).toList();
//     }
//     if (this.usage != null) {
//       data['usage'] = this.usage!.toJson();
//     }
//     return data;
//   }
// }
//
// class Choices {
//   String? text;
//   int? index;
//   Null? logprobs;
//   String? finishReason;
//
//   Choices({this.text, this.index, this.logprobs, this.finishReason});
//
//   Choices.fromJson(Map<String, dynamic> json) {
//     text = json['text'];
//     index = json['index'];
//     logprobs = json['logprobs'];
//     finishReason = json['finish_reason'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['text'] = this.text;
//     data['index'] = this.index;
//     data['logprobs'] = this.logprobs;
//     data['finish_reason'] = this.finishReason;
//     return data;
//   }
// }
//
// class Usage {
//   int? promptTokens;
//   int? completionTokens;
//   int? totalTokens;
//
//   Usage({this.promptTokens, this.completionTokens, this.totalTokens});
//
//   Usage.fromJson(Map<String, dynamic> json) {
//     promptTokens = json['prompt_tokens'];
//     completionTokens = json['completion_tokens'];
//     totalTokens = json['total_tokens'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['prompt_tokens'] = this.promptTokens;
//     data['completion_tokens'] = this.completionTokens;
//     data['total_tokens'] = this.totalTokens;
//     return data;
//   }
// }