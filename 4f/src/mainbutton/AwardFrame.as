package mainbutton
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.BossBoxManager;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.HelperUIModuleLoad;
   import ddt.view.bossbox.AwardsViewII;
   import ddt.view.bossbox.VipInfoTipBox;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import road7th.data.DictionaryData;
   import vip.view.VipViewFrame;
   
   public class AwardFrame extends Frame
   {
       
      
      private var _text:FilterFrameText;
      
      private var _topImgBG:MutipleImage;
      
      private var _vipBtn:BaseButton;
      
      private var _vipInfoTipBox:VipInfoTipBox;
      
      private var awards:AwardsViewII;
      
      private var alertFrame:BaseAlerFrame;
      
      public function AwardFrame(){super();}
      
      private function initView() : void{}
      
      private function addEvent() : void{}
      
      private function __vipOpen(param1:MouseEvent) : void{}
      
      private function showVipPackage() : void{}
      
      private function getVIPInfoTip(param1:DictionaryData) : Array{return null;}
      
      private function __responseVipInfoTipHandler(param1:FrameEvent) : void{}
      
      private function __alertHandler(param1:FrameEvent) : void{}
      
      private function __responseHandler(param1:FrameEvent) : void{}
      
      private function showAwards(param1:ItemTemplateInfo) : void{}
      
      private function _getStrArr(param1:DictionaryData) : Array{return null;}
      
      private function __sendReward(param1:Event) : void{}
      
      private function __confirmResponse(param1:FrameEvent) : void{}
      
      override public function dispose() : void{}
   }
}
