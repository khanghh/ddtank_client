package redEnvelope.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import redEnvelope.RedEnvelopeManager;
   import redEnvelope.data.RedInfo;
   import redEnvelope.event.RedEnvelopeEvent;
   
   public class RedEnvelopeMainFrame extends Frame implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      public var sendBtn:BaseButton;
      
      private var closeBtn:BaseButton;
      
      private var _redItemVec:Vector.<RedEnvelopeItem>;
      
      private var _redListVec:Vector.<RedEnvelopeInfoItem>;
      
      private var _listPanel:ScrollPanel;
      
      private var _infoListPanel:ScrollPanel;
      
      private var _vbox:VBox;
      
      private var _infoVbox:VBox;
      
      private var selectType:int;
      
      private var _ruleTxt:FilterFrameText;
      
      private var _timeTxt:FilterFrameText;
      
      private var index:int = 0;
      
      private var _title1Txt:FilterFrameText;
      
      private var _title2Txt:FilterFrameText;
      
      private var _redOver:Bitmap;
      
      public function RedEnvelopeMainFrame(){super();}
      
      private function initView() : void{}
      
      public function addNewRedEnvelope() : void{}
      
      public function updataRedNum() : void{}
      
      private function selectHandler(param1:RedEnvelopeEvent) : void{}
      
      private function chooseHandler(param1:RedEnvelopeEvent) : void{}
      
      public function setRedDark(param1:int) : void{}
      
      public function redRecordInfoUnsocket(param1:Array) : void{}
      
      public function redRecordInfo() : void{}
      
      private function initEvent() : void{}
      
      private function closeHandler(param1:MouseEvent) : void{}
      
      override protected function onFrameClose() : void{}
      
      private function clickHandler(param1:MouseEvent) : void{}
      
      private function removeEvent() : void{}
      
      override public function dispose() : void{}
   }
}

import com.pickgliss.ui.ComponentFactory;
import com.pickgliss.ui.core.Disposeable;
import com.pickgliss.ui.text.FilterFrameText;
import com.pickgliss.utils.ObjectUtils;
import ddt.manager.ItemManager;
import flash.display.Bitmap;
import flash.display.Sprite;

class RedRecord extends Sprite implements Disposeable
{
    
   
   private var _recordInfoTxt:FilterFrameText;
   
   private var _line:Bitmap;
   
   function RedRecord(){super();}
   
   public function setInfo(param1:String, param2:int, param3:int) : void{}
   
   public function dispose() : void{}
}
