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
      
      public function GameCard(){super();}
      
      public function set gameType(param1:int) : void{}
      
      private function __overHandler(param1:MouseEvent) : void{}
      
      private function __outHandler(param1:MouseEvent) : void{}
      
      public function set select(param1:Boolean) : void{}
      
      public function get select() : Boolean{return false;}
      
      public function get gameType() : int{return 0;}
      
      public function dispose() : void{}
   }
}
