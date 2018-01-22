package happyLittleGame.bombshellGame.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.utils.PositionUtils;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import uiModeManager.bombUI.model.bomb.BombRankInfo;
   
   public class BombRankItemIII extends Sprite implements Disposeable
   {
       
      
      private var _ranking:FilterFrameText;
      
      private var _nameTxt:FilterFrameText;
      
      private var _scoreTxt:FilterFrameText;
      
      private var _rank:int;
      
      private var _info:BombRankInfo;
      
      private var _nameDis:String;
      
      private var _tipbackgound:Image;
      
      private var _tipDis:FilterFrameText;
      
      public function BombRankItemIII(){super();}
      
      private function initView() : void{}
      
      private function initEvent() : void{}
      
      private function __overHandler(param1:MouseEvent) : void{}
      
      private function __outHandler(param1:MouseEvent) : void{}
      
      private function removeEvent() : void{}
      
      public function setRank(param1:int) : void{}
      
      public function set Info(param1:BombRankInfo) : void{}
      
      public function clear() : void{}
      
      public function dispose() : void{}
   }
}
