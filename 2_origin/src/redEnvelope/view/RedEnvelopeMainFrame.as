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
      
      public function RedEnvelopeMainFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         var _loc11_:int = 0;
         var _loc5_:* = null;
         var _loc7_:int = 0;
         var _loc4_:* = null;
         var _loc3_:* = null;
         var _loc9_:int = 0;
         var _loc6_:* = null;
         var _loc1_:* = null;
         var _loc8_:int = 0;
         var _loc10_:* = null;
         var _loc2_:* = null;
         _bg = ComponentFactory.Instance.creatBitmap("asset.redEnvelope.bg");
         addChild(_bg);
         _redOver = ComponentFactory.Instance.creatBitmap("asset.redEnvelope.redOver");
         addChild(_redOver);
         _redOver.visible = false;
         _title1Txt = ComponentFactory.Instance.creatComponentByStylename("redEnvelope.titleTxt");
         addChild(_title1Txt);
         _title1Txt.text = LanguageMgr.GetTranslation("ddt.redEnvelope.redNum");
         _title2Txt = ComponentFactory.Instance.creatComponentByStylename("redEnvelope.titleTxt");
         addChild(_title2Txt);
         _title2Txt.text = LanguageMgr.GetTranslation("ddt.redEnvelope.prize");
         PositionUtils.setPos(_title2Txt,"asset.redEnvelope.prizePos");
         _ruleTxt = ComponentFactory.Instance.creatComponentByStylename("redEnvelope.ruleTxt");
         addChild(_ruleTxt);
         _ruleTxt.text = LanguageMgr.GetTranslation("ddt.redEnvelope.help");
         _timeTxt = ComponentFactory.Instance.creatComponentByStylename("redEnvelope.timeTxt");
         addChild(_timeTxt);
         _timeTxt.text = LanguageMgr.GetTranslation("ddt.redEnvelope.time",RedEnvelopeManager.instance.model.beginDateStr,RedEnvelopeManager.instance.model.endDateStr);
         sendBtn = ComponentFactory.Instance.creatComponentByStylename("redEnvelope.sendBtn");
         addChild(sendBtn);
         closeBtn = ComponentFactory.Instance.creatComponentByStylename("redEnvelope.closeBtn");
         addChild(closeBtn);
         _redItemVec = new Vector.<RedEnvelopeItem>();
         _loc11_ = 1;
         while(_loc11_ <= 4)
         {
            _loc5_ = new RedEnvelopeItem(_loc11_);
            _loc5_.addEventListener("select",selectHandler);
            _loc5_.x = 17;
            _loc5_.y = 99 + 49 * (_loc11_ - 1);
            addChild(_loc5_);
            _redItemVec.push(_loc5_);
            _loc11_++;
         }
         _redListVec = new Vector.<RedEnvelopeInfoItem>();
         index = 0;
         _vbox = new VBox();
         _vbox.spacing = -12;
         _loc7_ = 0;
         while(_loc7_ < RedEnvelopeManager.instance.model.myRedEnvelopeList.length)
         {
            _loc4_ = RedEnvelopeManager.instance.model.myRedEnvelopeList[_loc7_];
            _loc3_ = new RedEnvelopeInfoItem(index,_loc4_.type,_loc4_.sendName,_loc4_.id,true);
            _loc3_.addEventListener("choose",chooseHandler);
            _vbox.addChild(_loc3_);
            _redListVec.push(_loc3_);
            index = Number(index) + 1;
            _loc7_++;
         }
         _loc9_ = 0;
         while(_loc9_ < RedEnvelopeManager.instance.model.canGetList.length)
         {
            _loc6_ = RedEnvelopeManager.instance.model.canGetList[_loc9_];
            _loc1_ = new RedEnvelopeInfoItem(index,_loc6_.type,_loc6_.sendName,_loc6_.id,true);
            _loc1_.addEventListener("choose",chooseHandler);
            _vbox.addChild(_loc1_);
            _redListVec.push(_loc1_);
            index = Number(index) + 1;
            _loc9_++;
         }
         _loc8_ = 0;
         while(_loc8_ < RedEnvelopeManager.instance.model.hasGotList.length)
         {
            _loc10_ = RedEnvelopeManager.instance.model.hasGotList[_loc8_];
            _loc2_ = new RedEnvelopeInfoItem(index,_loc10_.type,_loc10_.sendName,_loc10_.id,false);
            _loc2_.addEventListener("choose",chooseHandler);
            _vbox.addChild(_loc2_);
            _redListVec.push(_loc2_);
            index = Number(index) + 1;
            _loc8_++;
         }
         index = 1;
         _listPanel = ComponentFactory.Instance.creatComponentByStylename("redEnvelope.unitScrollPanel");
         _listPanel.setView(_vbox);
         _listPanel.invalidateViewport();
         addChild(_listPanel);
         if(_redListVec.length > 0)
         {
            _redListVec[0].dispatchEvent(new MouseEvent("click"));
         }
         else
         {
            _redOver.visible = true;
         }
      }
      
      public function addNewRedEnvelope() : void
      {
         _redOver.visible = false;
         var _loc2_:RedInfo = RedEnvelopeManager.instance.model.newRedEnvelope;
         var _loc1_:RedEnvelopeInfoItem = new RedEnvelopeInfoItem(index,_loc2_.type,_loc2_.sendName,_loc2_.id,true);
         _loc1_.addEventListener("choose",chooseHandler);
         _vbox.isReverAdd = true;
         _vbox.isReverAddList = true;
         _vbox.addChild(_loc1_);
         _vbox.arrange();
         _redListVec.push(_loc1_);
         _listPanel.commitChanges();
         index = Number(index) + 1;
         if(_redListVec.length == 1)
         {
            _redListVec[0].dispatchEvent(new MouseEvent("click"));
         }
      }
      
      public function updataRedNum() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _redItemVec.length)
         {
            _redItemVec[_loc1_].updataRedNum();
            _loc1_++;
         }
      }
      
      private function selectHandler(param1:RedEnvelopeEvent) : void
      {
         var _loc2_:int = 0;
         selectType = param1.resultData;
         _loc2_ = 0;
         while(_loc2_ < _redItemVec.length)
         {
            if(_redItemVec[_loc2_]._type != param1.resultData)
            {
               _redItemVec[_loc2_].select.movie.gotoAndStop(1);
            }
            _loc2_++;
         }
      }
      
      private function chooseHandler(param1:RedEnvelopeEvent) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < _redListVec.length)
         {
            if(_redListVec[_loc3_]._id != param1.resultData)
            {
               _redListVec[_loc3_].unSelectSet();
            }
            _loc3_++;
         }
         _loc2_ = 0;
         while(_loc2_ < RedEnvelopeManager.instance.model.emptyList.length)
         {
            if(param1.resultData == RedEnvelopeManager.instance.model.emptyList[_loc2_].id)
            {
               redRecordInfoUnsocket(RedEnvelopeManager.instance.model.emptyList[_loc2_].info);
               RedEnvelopeManager.instance.checkCanClick = true;
               return;
            }
            _loc2_++;
         }
         SocketManager.Instance.out.redEnvelopeInfo(param1.resultData);
      }
      
      public function setRedDark(param1:int) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < _redListVec.length)
         {
            if(_redListVec[_loc2_]._id == param1)
            {
               _redListVec[_loc2_].btnDarkSet();
               return;
            }
            _loc2_++;
         }
      }
      
      public function redRecordInfoUnsocket(param1:Array) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = null;
         var _loc2_:* = null;
         if(_infoVbox)
         {
            ObjectUtils.disposeObject(_infoVbox);
         }
         _infoVbox = null;
         if(_infoListPanel)
         {
            ObjectUtils.disposeObject(_infoListPanel);
         }
         _infoListPanel = null;
         _infoVbox = new VBox();
         _infoVbox.spacing = 5;
         _loc4_ = 0;
         while(_loc4_ < param1.length)
         {
            _loc3_ = new RedRecord();
            _loc2_ = param1[_loc4_].split(",");
            _loc3_.setInfo(_loc2_[0],parseInt(_loc2_[1]),parseInt(_loc2_[2]));
            _infoVbox.addChild(_loc3_);
            _loc4_++;
         }
         _infoListPanel = ComponentFactory.Instance.creatComponentByStylename("redEnvelope.info.unitScrollPanel");
         _infoListPanel.setView(_infoVbox);
         _infoListPanel.invalidateViewport();
         addChild(_infoListPanel);
      }
      
      public function redRecordInfo() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         var _loc1_:* = null;
         if(_infoVbox)
         {
            ObjectUtils.disposeObject(_infoVbox);
         }
         _infoVbox = null;
         if(_infoListPanel)
         {
            ObjectUtils.disposeObject(_infoListPanel);
         }
         _infoListPanel = null;
         _infoVbox = new VBox();
         _infoVbox.spacing = 5;
         _loc3_ = 0;
         while(_loc3_ < RedEnvelopeManager.instance.model.currentRedList.length)
         {
            _loc2_ = new RedRecord();
            _loc1_ = RedEnvelopeManager.instance.model.currentRedList[_loc3_].split(",");
            _loc2_.setInfo(_loc1_[0],parseInt(_loc1_[1]),parseInt(_loc1_[2]));
            _infoVbox.addChild(_loc2_);
            _loc3_++;
         }
         _infoListPanel = ComponentFactory.Instance.creatComponentByStylename("redEnvelope.info.unitScrollPanel");
         _infoListPanel.setView(_infoVbox);
         _infoListPanel.invalidateViewport();
         addChild(_infoListPanel);
      }
      
      private function initEvent() : void
      {
         sendBtn.addEventListener("click",clickHandler);
         closeBtn.addEventListener("click",closeHandler);
      }
      
      private function closeHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         RedEnvelopeManager.instance.closeFrame();
      }
      
      override protected function onFrameClose() : void
      {
         SoundManager.instance.play("008");
         RedEnvelopeManager.instance.closeFrame();
      }
      
      private function clickHandler(param1:MouseEvent) : void
      {
         if(selectType == 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.redEnvelope.pleaseChoose"));
            return;
         }
         SoundManager.instance.play("008");
         SocketManager.Instance.out.sendRedEnvelope(selectType);
      }
      
      private function removeEvent() : void
      {
         sendBtn.removeEventListener("click",clickHandler);
         closeBtn.removeEventListener("click",closeHandler);
      }
      
      override public function dispose() : void
      {
         var _loc1_:int = 0;
         super.dispose();
         removeEvent();
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(sendBtn)
         {
            ObjectUtils.disposeObject(sendBtn);
         }
         sendBtn = null;
         if(closeBtn)
         {
            ObjectUtils.disposeObject(closeBtn);
         }
         closeBtn = null;
         if(_vbox)
         {
            ObjectUtils.disposeObject(_vbox);
         }
         _vbox = null;
         if(_infoVbox)
         {
            ObjectUtils.disposeObject(_infoVbox);
         }
         _infoVbox = null;
         if(_listPanel)
         {
            ObjectUtils.disposeObject(_listPanel);
         }
         _listPanel = null;
         if(_infoListPanel)
         {
            ObjectUtils.disposeObject(_infoListPanel);
         }
         _infoListPanel = null;
         if(_ruleTxt)
         {
            ObjectUtils.disposeObject(_ruleTxt);
         }
         _ruleTxt = null;
         if(_timeTxt)
         {
            ObjectUtils.disposeObject(_timeTxt);
         }
         _timeTxt = null;
         if(_title1Txt)
         {
            ObjectUtils.disposeObject(_title1Txt);
         }
         _title1Txt = null;
         if(_title2Txt)
         {
            ObjectUtils.disposeObject(_title2Txt);
         }
         _title2Txt = null;
         if(_redOver)
         {
            ObjectUtils.disposeObject(_redOver);
         }
         _redOver = null;
         _loc1_ = 0;
         while(_loc1_ < _redItemVec.length)
         {
            ObjectUtils.disposeObject(_redItemVec[_loc1_]);
            _loc1_++;
         }
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
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
   
   function RedRecord()
   {
      super();
      _recordInfoTxt = ComponentFactory.Instance.creatComponentByStylename("redEnvelope.recordInfoTxt");
      addChild(_recordInfoTxt);
      _line = ComponentFactory.Instance.creatBitmap("asset.redEnvelope.line");
      addChild(_line);
   }
   
   public function setInfo(param1:String, param2:int, param3:int) : void
   {
      _recordInfoTxt.text = "[" + param1 + "]" + ItemManager.Instance.getTemplateById(param2).Name + "x" + String(param3);
   }
   
   public function dispose() : void
   {
      if(_recordInfoTxt)
      {
         ObjectUtils.disposeObject(_recordInfoTxt);
      }
      _recordInfoTxt = null;
      if(_line)
      {
         ObjectUtils.disposeObject(_line);
      }
      _line = null;
   }
}
