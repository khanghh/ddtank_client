package homeTemple.view
{
   import com.greensock.TweenLite;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import homeTemple.HomeTempleController;
   import homeTemple.data.HomeTempleModel;
   import homeTemple.event.HomeTempleEvent;
   
   public class HomeTempleBlessing extends Sprite implements Disposeable
   {
      
      public static var StartNum:int = 0;
       
      
      private var _bloodText:FilterFrameText;
      
      private var _defenseText:FilterFrameText;
      
      private var _attackText:FilterFrameText;
      
      private var _armorText:FilterFrameText;
      
      private var _resistanceText:FilterFrameText;
      
      private var _luckyText:FilterFrameText;
      
      private var _leftBtn:BaseButton;
      
      private var _rightBtn:BaseButton;
      
      private var _blessSprite:Sprite;
      
      private var _blessList:Vector.<HomeTempleBlessItem>;
      
      private var _tipBtnVec:Vector.<BaseButton>;
      
      private var _blessPosArr:Array;
      
      public function HomeTempleBlessing(){super();}
      
      private function initView() : void{}
      
      private function creatTipBtn() : void{}
      
      private function setTextInfo() : void{}
      
      private function initEvent() : void{}
      
      protected function __onUpdateBlessingState(param1:HomeTempleEvent) : void{}
      
      private function creatBless() : void{}
      
      protected function __onBlessClick(param1:MouseEvent) : void{}
      
      public function resetBlessingPos() : void{}
      
      private function updateBlessPos() : void{}
      
      private function updateTipBtn() : void{}
      
      private function getPosIndex(param1:int) : int{return 0;}
      
      protected function __onLeftBtnClick(param1:MouseEvent) : void{}
      
      protected function __onRightBtnClick(param1:MouseEvent) : void{}
      
      private function removeEvent() : void{}
      
      public function dispose() : void{}
   }
}
