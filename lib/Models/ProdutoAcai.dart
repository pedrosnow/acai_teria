class ProdutoAcai {
  int _idProduto;
  String _produto;
  dynamic _preco;
  String _complemento;
  String _img;
  int get idProduto => this._idProduto;

  set idProduto(int value) => this._idProduto = value;

  get produto => this._produto;

  set produto(value) => this._produto = value;

  get preco => this._preco;

  set preco(value) => this._preco = value;

  get complemento => this._complemento;

  set complemento(value) => this._complemento = value;

  get img => this._img;

  set img(value) => this._img = value;
}
