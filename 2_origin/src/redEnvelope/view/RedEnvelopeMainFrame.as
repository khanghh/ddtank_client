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
         var i:int = 0;
         var item:* = null;
         var l:int = 0;
         var myRedInfo:* = null;
         var item3:* = null;
         var k:int = 0;
         var redInfo1:* = null;
         var item2:* = null;
         var j:int = 0;
         var redInfo:* = null;
         var item1:* = null;
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
         for(i = 1; i <= 4; )
         {
            item = new RedEnvelopeItem(i);
            item.addEventListener("select",selectHandler);
            item.x = 17;
            item.y = 99 + 49 * (i - 1);
            addChild(item);
            _redItemVec.push(item);
            i++;
         }
         _redListVec = new Vector.<RedEnvelopeInfoItem>();
         index = 0;
         _vbox = new VBox();
         _vbox.spacing = -12;
         for(l = 0; l < RedEnvelopeManager.instance.model.myRedEnvelopeList.length; )
         {
            myRedInfo = RedEnvelopeManager.instance.model.myRedEnvelopeList[l];
            item3 = new RedEnvelopeInfoItem(index,myRedInfo.type,myRedInfo.sendName,myRedInfo.id,true);
            item3.addEventListener("choose",chooseHandler);
            _vbox.addChild(item3);
            _redListVec.push(item3);
            index = Number(index) + 1;
            l++;
         }
         for(k = 0; k < RedEnvelopeManager.instance.model.canGetList.length; )
         {
            redInfo1 = RedEnvelopeManager.instance.model.canGetList[k];
            item2 = new RedEnvelopeInfoItem(index,redInfo1.type,redInfo1.sendName,redInfo1.id,true);
            item2.addEventListener("choose",chooseHandler);
            _vbox.addChild(item2);
            _redListVec.push(item2);
            index = Number(index) + 1;
            k++;
         }
         for(j = 0; j < RedEnvelopeManager.instance.model.hasGotList.length; )
         {
            redInfo = RedEnvelopeManager.instance.model.hasGotList[j];
            item1 = new RedEnvelopeInfoItem(index,redInfo.type,redInfo.sendName,redInfo.id,false);
            item1.addEventListener("choose",chooseHandler);
            _vbox.addChild(item1);
            _redListVec.push(item1);
            index = Number(index) + 1;
            j++;
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
         var redInfo:RedInfo = RedEnvelopeManager.instance.model.newRedEnvelope;
         var item:RedEnvelopeInfoItem = new RedEnvelopeInfoItem(index,redInfo.type,redInfo.sendName,redInfo.id,true);
         item.addEventListener("choose",chooseHandler);
         _vbox.isReverAdd = true;
         _vbox.isReverAddList = true;
         _vbox.addChild(item);
         _vbox.arrange();
         _redListVec.push(item);
         _listPanel.commitChanges();
         index = Number(index) + 1;
         if(_redListVec.length == 1)
         {
            _redListVec[0].dispatchEvent(new MouseEvent("click"));
         }
      }
      
      public function updataRedNum() : void
      {
         var i:int = 0;
         for(i = 0; i < _redItemVec.length; )
         {
            _redItemVec[i].updataRedNum();
            i++;
         }
      }
      
      private function selectHandler(e:RedEnvelopeEvent) : void
      {
         var i:int = 0;
         selectType = e.resultData;
         for(i = 0; i < _redItemVec.length; )
         {
            if(_redItemVec[i]._type != e.resultData)
            {
               _redItemVec[i].select.movie.gotoAndStop(1);
            }
            i++;
         }
      }
      
      private function chooseHandler(e:RedEnvelopeEvent) : void
      {
         var i:int = 0;
         var j:int = 0;
         for(i = 0; i < _redListVec.length; )
         {
            if(_redListVec[i]._id != e.resultData)
            {
               _redListVec[i].unSelectSet();
            }
            i++;
         }
         for(j = 0; j < RedEnvelopeManager.instance.model.emptyList.length; )
         {
            if(e.resultData == RedEnvelopeManager.instance.model.emptyList[j].id)
            {
               redRecordInfoUnsocket(RedEnvelopeManager.instance.model.emptyList[j].info);
               RedEnvelopeManager.instance.checkCanClick = true;
               return;
            }
            j++;
         }
         SocketManager.Instance.out.redEnvelopeInfo(e.resultData);
      }
      
      public function setRedDark(id:int) : void
      {
         var i:int = 0;
         for(i = 0; i < _redListVec.length; )
         {
            if(_redListVec[i]._id == id)
            {
               _redListVec[i].btnDarkSet();
               return;
            }
            i++;
         }
      }
      
      public function redRecordInfoUnsocket(list:Array) : void
      {
         var i:int = 0;
         var _redRecord:* = null;
         var arr:* = null;
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
         for(i = 0; i < list.length; )
         {
            _redRecord = new RedRecord();
            arr = list[i].split(",");
            _redRecord.setInfo(arr[0],parseInt(arr[1]),parseInt(arr[2]));
            _infoVbox.addChild(_redRecord);
            i++;
         }
         _infoListPanel = ComponentFactory.Instance.creatComponentByStylename("redEnvelope.info.unitScrollPanel");
         _infoListPanel.setView(_infoVbox);
         _infoListPanel.invalidateViewport();
         addChild(_infoListPanel);
      }
      
      public function redRecordInfo() : void
      {
         var i:int = 0;
         var _redRecord:* = null;
         var arr:* = null;
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
         for(i = 0; i < RedEnvelopeManager.instance.model.currentRedList.length; )
         {
            _redRecord = new RedRecord();
            arr = RedEnvelopeManager.instance.model.currentRedList[i].split(",");
            _redRecord.setInfo(arr[0],parseInt(arr[1]),parseInt(arr[2]));
            _infoVbox.addChild(_redRecord);
            i++;
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
      
      private function closeHandler(e:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         RedEnvelopeManager.instance.closeFrame();
      }
      
      override protected function onFrameClose() : void
      {
         SoundManager.instance.play("008");
         RedEnvelopeManager.instance.closeFrame();
      }
      
      private function clickHandler(e:MouseEvent) : void
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
         var i:int = 0;
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
         for(i = 0; i < _redItemVec.length; )
         {
            ObjectUtils.disposeObject(_redItemVec[i]);
            i++;
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
   
   public function setInfo(name:String, id:int, num:int) : void
   {
      _recordInfoTxt.text = "[" + name + "]" + ItemManager.Instance.getTemplateById(id).Name + "x" + String(num);
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
