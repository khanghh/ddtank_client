package ddt
{
   import com.greensock.TweenMax;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.EquipType;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.ChatManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SoundManager;
   import ddt.utils.StaticFormula;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class TipImage extends Sprite implements Disposeable
   {
      
      public static const TRANSFER:int = 0;
      
      public static const EMBED:int = 1;
      
      public static const BEGIN_Y:int = 130;
      
      public static const SPACING:String = " ";
      
      public static const SPACINGII:String = " +";
      
      public static const SPACINGIII:String = " ";
      
      public static const Shield:int = 31;
       
      
      private var _timer:Timer;
      
      public var _successBit:Bitmap;
      
      public var _failBit:Bitmap;
      
      public var _fiveFailBit:Bitmap;
      
      private var _moveSprite:Sprite;
      
      public var isDisplayerTip:Boolean = true;
      
      private var _lastTipString:String = "";
      
      public function TipImage(){super();}
      
      private function init() : void{}
      
      private function createTween(param1:Function = null, param2:Array = null) : void{}
      
      private function showPropertyChange(param1:InventoryItemInfo) : String{return null;}
      
      private function showHoleTip(param1:InventoryItemInfo) : String{return null;}
      
      private function showOpenHoleTip(param1:InventoryItemInfo) : String{return null;}
      
      public function showSuccess() : void{}
      
      public function showStrengthSuccess(param1:InventoryItemInfo, param2:Boolean) : void{}
      
      private function strengthTweenComplete(param1:String) : void{}
      
      public function showEmbedSuccess(param1:InventoryItemInfo) : void{}
      
      private function embedTweenComplete() : void{}
      
      public function showFail() : void{}
      
      public function showFiveFail() : void{}
      
      private function __timerComplete(param1:TimerEvent) : void{}
      
      private function removeTips() : void{}
      
      public function dispose() : void{}
   }
}
