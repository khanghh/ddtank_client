package ddt.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.tip.BaseTip;
   import com.pickgliss.ui.tip.ITip;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.StateManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.utils.getDefinitionByName;
   
   public class LevelTip extends BaseTip implements ITip
   {
      
      private static var _instance:LevelTip;
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _lv:Bitmap;
      
      private var _ddtKingGradeText:FilterFrameText;
      
      private var _repute:Repute;
      
      private var _winRate:WinRate;
      
      private var _battle:Battle;
      
      private var _exploit:Exploit;
      
      private var _tipContainer:Sprite;
      
      private var _level:int;
      
      private var _reputeCount:int;
      
      private var _win:int;
      
      private var _total:int;
      
      private var _enableTip:Boolean;
      
      private var _tip:Sprite;
      
      private var _tipInfo:Object;
      
      private var _battleNum:int;
      
      private var _exploitValue:int;
      
      private var _bgH:int;
      
      public function LevelTip(){super();}
      
      public static function get instance() : LevelTip{return null;}
      
      override protected function init() : void{}
      
      override protected function addChildren() : void{}
      
      public function get txtPos() : Point{return null;}
      
      override public function get tipData() : Object{return null;}
      
      override public function set tipData(param1:Object) : void{}
      
      private function updateWH() : void{}
      
      private function createLevelTip() : void{}
      
      private function makeTip(param1:Object) : void{}
      
      private function resetLevelTip(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int, param7:int, param8:Boolean = true, param9:int = 1) : void{}
      
      private function setRepute(param1:int, param2:int) : void{}
      
      private function setRate(param1:int, param2:int) : void{}
      
      private function setBattle(param1:int) : void{}
      
      private function setExploit(param1:int) : void{}
      
      private function updateTip() : void{}
      
      override public function dispose() : void{}
   }
}
