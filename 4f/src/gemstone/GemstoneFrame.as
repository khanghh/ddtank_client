package gemstone
{
   import com.pickgliss.events.UIModuleEvent;
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.UIModuleLoader;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.SelfInfo;
   import ddt.manager.PlayerManager;
   import ddt.view.UIModuleSmallLoading;
   import flash.display.Sprite;
   import gemstone.info.GemstoneStaticInfo;
   import gemstone.info.GemstoneUpGradeInfo;
   import gemstone.items.ExpBar;
   import gemstone.views.GemstoneCurInfo;
   import gemstone.views.GemstoneInfoView;
   import gemstone.views.GemstoneObtainView;
   import gemstone.views.GemstoneUpView;
   
   public class GemstoneFrame extends Frame
   {
       
      
      private var _gemstoneObtainView:GemstoneObtainView;
      
      private var _gemstoneInfoView:GemstoneInfoView;
      
      private var _gemstoneUpView:GemstoneUpView;
      
      private var _selfInfo:SelfInfo;
      
      private var _bg:ScaleBitmapImage;
      
      private var _gemstoneCurInfo:GemstoneCurInfo;
      
      private var _loader:BaseLoader;
      
      private var _gInfoList:Vector.<GemstoneStaticInfo>;
      
      public var redInfoList:Vector.<GemstoneStaticInfo>;
      
      public var buleInfoList:Vector.<GemstoneStaticInfo>;
      
      public var greeInfoList:Vector.<GemstoneStaticInfo>;
      
      public var yellInfoList:Vector.<GemstoneStaticInfo>;
      
      private var _goundMask:Sprite;
      
      public function GemstoneFrame(){super();}
      
      private function gemstoneProgress(param1:UIModuleEvent) : void{}
      
      private function gemstoneCompHander(param1:UIModuleEvent) : void{}
      
      public function initView() : void{}
      
      public function firstTimeUpdateUpGradeButton() : void{}
      
      public function updateUpButton() : void{}
      
      public function upDatafitCount() : void{}
      
      public function getMaskMc() : Sprite{return null;}
      
      public function gemstoneAction(param1:GemstoneUpGradeInfo) : void{}
      
      public function get expBar() : ExpBar{return null;}
      
      override public function dispose() : void{}
   }
}
