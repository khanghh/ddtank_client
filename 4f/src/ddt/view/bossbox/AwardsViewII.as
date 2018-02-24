package ddt.view.bossbox
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.box.BoxGoodsTempInfo;
   import ddt.manager.BossBoxManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SoundManager;
   import ddt.manager.TimeManager;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import mainbutton.MainButtnController;
   
   public class AwardsViewII extends Frame
   {
      
      public static const HAVEBTNCLICK:String = "_haveBtnClick";
       
      
      private var _timeTypeTxt:FilterFrameText;
      
      private var _goodsList:Array;
      
      private var _boxType:int;
      
      private var _button:TextButton;
      
      private var list:AwardsGoodsList;
      
      private var GoodsBG:ScaleBitmapImage;
      
      public function AwardsViewII(){super();}
      
      private function initII() : void{}
      
      private function initEvent() : void{}
      
      private function _click(param1:MouseEvent) : void{}
      
      private function __onResponse(param1:FrameEvent) : void{}
      
      private function __frameEventHandler(param1:FrameEvent) : void{}
      
      public function set boxType(param1:int) : void{}
      
      public function get boxType() : int{return 0;}
      
      public function set goodsList(param1:Array) : void{}
      
      public function set vipAwardGoodsList(param1:Array) : void{}
      
      public function set fightLibAwardGoodList(param1:Array) : void{}
      
      public function setCheck() : void{}
      
      private function updateTime() : String{return null;}
      
      override public function dispose() : void{}
   }
}
