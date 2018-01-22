package ddtmatch.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddtmatch.data.RedPacketInfo;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class DDTMatchRedPacketItem extends Sprite implements Disposeable
   {
       
      
      private var _type:int;
      
      private var _index:int;
      
      private var _bg:Bitmap;
      
      private var _robPacketBtn:SimpleBitmapButton;
      
      private var _robrecordBtn:SimpleBitmapButton;
      
      private var _descriptAllTxt:FilterFrameText;
      
      private var _descriptPlayerTxt:FilterFrameText;
      
      private var _info:RedPacketInfo;
      
      private var recordView:DDTMatchRedPacketRecord;
      
      public function DDTMatchRedPacketItem(param1:int, param2:int)
      {
         super();
         _type = param1;
         _index = param2;
         initView();
         addEvent();
      }
      
      public function get info() : RedPacketInfo
      {
         return _info;
      }
      
      public function set info(param1:RedPacketInfo) : void
      {
         _info = param1;
         if(_type == 1)
         {
            _descriptAllTxt.text = LanguageMgr.GetTranslation("ddt.DDTMatch.redpacket.systemPacket");
         }
         else
         {
            _descriptPlayerTxt.text = LanguageMgr.GetTranslation("ddt.DDTMatch.redpacket.playerPacket",_info.nickName);
         }
         if(info.ifGet)
         {
            _robPacketBtn.enable = false;
            _robPacketBtn.filters = ComponentFactory.Instance.creatFilters("grayFilter");
         }
         else if(_info.status == 0 || _info.status == 1)
         {
            _robPacketBtn.enable = true;
            _robPacketBtn.filters = null;
         }
         else if(_info.status == 2)
         {
            _robPacketBtn.enable = false;
            _robPacketBtn.filters = ComponentFactory.Instance.creatFilters("grayFilter");
         }
      }
      
      private function initView() : void
      {
         _descriptAllTxt = ComponentFactory.Instance.creatComponentByStylename("ddtmatch.redpacket.descriptAllTxt");
         _descriptPlayerTxt = ComponentFactory.Instance.creatComponentByStylename("ddtmatch.redpacket.descriptPlayerTxt");
         if(_type == 1)
         {
            _descriptAllTxt.visible = true;
            _descriptPlayerTxt.visible = false;
            if(_index % 2 == 0)
            {
               _bg = ComponentFactory.Instance.creatBitmap("ddtmatch.redPacket.allLightBg");
            }
            else
            {
               _bg = ComponentFactory.Instance.creatBitmap("ddtmatch.redPacket.allDarkBg");
            }
         }
         else
         {
            _descriptAllTxt.visible = false;
            _descriptPlayerTxt.visible = true;
            if(_index % 2 == 0)
            {
               _bg = ComponentFactory.Instance.creatBitmap("ddtmatch.redPacket.playerLightBg");
            }
            else
            {
               _bg = ComponentFactory.Instance.creatBitmap("ddtmatch.redPacket.playerDarktBg");
            }
         }
         addChild(_bg);
         addChild(_descriptAllTxt);
         addChild(_descriptPlayerTxt);
         _robPacketBtn = ComponentFactory.Instance.creatComponentByStylename("asset.ddtmatch.redPacket.robPacketBtn");
         addChild(_robPacketBtn);
         _robrecordBtn = ComponentFactory.Instance.creatComponentByStylename("asset.ddtmatch.redPacket.robRecordBtn");
         addChild(_robrecordBtn);
      }
      
      private function addEvent() : void
      {
         _robPacketBtn.addEventListener("click",_robPacketBtnHandler);
         _robrecordBtn.addEventListener("click",_robrecordBtnHandler);
      }
      
      private function _robPacketBtnHandler(param1:MouseEvent) : void
      {
         SocketManager.Instance.out.getRobRedPacket(_info.id);
         _robPacketBtn.enable = false;
         _robPacketBtn.filters = ComponentFactory.Instance.creatFilters("grayFilter");
      }
      
      private function _robrecordBtnHandler(param1:MouseEvent) : void
      {
         recordView = ComponentFactory.Instance.creatComponentByStylename("redPacketRecordFrame");
         recordView.setInfo(_info);
         recordView.addEventListener("response",__respose);
         LayerManager.Instance.addToLayer(recordView,3,true,2);
      }
      
      private function __respose(param1:FrameEvent) : void
      {
         if(param1.responseCode == 0 || param1.responseCode == 1)
         {
            recordView.dispose();
         }
      }
      
      private function removeEvent() : void
      {
         _robPacketBtn.removeEventListener("click",_robPacketBtnHandler);
         _robrecordBtn.removeEventListener("click",_robrecordBtnHandler);
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_robPacketBtn);
         _robPacketBtn = null;
         ObjectUtils.disposeObject(_robrecordBtn);
         _robrecordBtn = null;
         ObjectUtils.disposeObject(_descriptAllTxt);
         _descriptAllTxt = null;
         ObjectUtils.disposeObject(_descriptPlayerTxt);
         _descriptPlayerTxt = null;
         ObjectUtils.disposeObject(recordView);
         recordView = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
