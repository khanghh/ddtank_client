package happyLittleGame
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class GameCard extends Sprite implements Disposeable
   {
       
      
      private var _cardImage:Bitmap;
      
      private var _gameType:int;
      
      private var _selectImage:Bitmap;
      
      private var _select:Boolean;
      
      public function GameCard()
      {
         super();
         _selectImage = ComponentFactory.Instance.creatBitmap("asset.happygame.card.select");
         _selectImage.visible = false;
      }
      
      public function set gameType(value:int) : void
      {
         _gameType = value;
         if(_gameType == 2)
         {
            _cardImage = ComponentFactory.Instance.creatBitmap("asset.bombgame.outpos");
         }
         else if(_gameType == 1)
         {
            _cardImage = ComponentFactory.Instance.creatBitmap("asset.bombgame.points");
         }
         else if(_gameType == 3)
         {
            _cardImage = ComponentFactory.Instance.creatBitmap("asset.cubeGame.princessCard");
         }
         _cardImage.addEventListener("mouseOver",__overHandler);
         _cardImage.addEventListener("mouseOut",__outHandler);
         addChild(_cardImage);
         addChild(_selectImage);
      }
      
      private function __overHandler(evt:MouseEvent) : void
      {
         buttonMode = true;
      }
      
      private function __outHandler(evt:MouseEvent) : void
      {
         buttonMode = false;
      }
      
      public function set select(value:Boolean) : void
      {
         _select = value;
         if(value)
         {
            _selectImage.visible = true;
            _cardImage.filters = ComponentFactory.Instance.creatFilters("lightFilter");
         }
         else
         {
            _selectImage.visible = false;
            _cardImage.filters = null;
         }
      }
      
      public function get select() : Boolean
      {
         return _select;
      }
      
      public function get gameType() : int
      {
         return _gameType;
      }
      
      public function dispose() : void
      {
         if(_cardImage)
         {
            _cardImage.removeEventListener("mouseOver",__overHandler);
            _cardImage.removeEventListener("mouseOut",__outHandler);
            ObjectUtils.disposeObject(_cardImage);
            _cardImage = null;
         }
         if(_selectImage)
         {
            ObjectUtils.disposeObject(_selectImage);
            _selectImage = null;
         }
      }
   }
}
