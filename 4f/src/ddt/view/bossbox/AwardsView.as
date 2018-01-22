package ddt.view.bossbox
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.BossBoxManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import ddt.manager.TimeManager;
   import ddt.utils.Helpers;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class AwardsView extends Frame
   {
      
      public static const HAVEBTNCLICK:String = "_haveBtnClick";
       
      
      private var _timeTip:ScaleFrameImage;
      
      private var _goodsList:Array;
      
      private var _boxType:int;
      
      private var _button:TextButton;
      
      private var list:AwardsGoodsList;
      
      private var GoodsBG:ScaleBitmapImage;
      
      private var _view:MutipleImage;
      
      public function AwardsView(){super();}
      
      private function initII() : void{}
      
      private function initEvent() : void{}
      
      private function _click(param1:MouseEvent) : void{}
      
      private function __frameEventHandler(param1:FrameEvent) : void{}
      
      public function set boxType(param1:int) : void{}
      
      public function get boxType() : int{return 0;}
      
      public function set goodsList(param1:Array) : void{}
      
      public function set vipAwardGoodsList(param1:Array) : void{}
      
      public function set fightLibAwardGoodList(param1:Array) : void{}
      
      public function setCheck() : void{}
      
      private function updateTime() : String{return null;}
      
      override public function dispose() : void{}
      
      public function get goodsList() : Array{return null;}
   }
}
