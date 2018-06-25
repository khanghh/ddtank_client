package exitPrompt
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class ExitAllButton extends Component
   {
      
      public static const CHANGE:String = "change";
       
      
      private var _dayMissionBt:ExitButtonItem;
      
      private var _dayMissionSprite:MissionSprite;
      
      private var _actMissionBt:ExitButtonItem;
      
      private var _actMissionSprite:MissionSprite;
      
      private var _emailMissionBt:ExitButtonItem;
      
      private var _bullet1:Bitmap;
      
      private var _bullet2:Bitmap;
      
      private var _bullet3:Bitmap;
      
      private var _viewArr:Array;
      
      private var _model:ExitPromptModel;
      
      private var _dayMissionInfoText:FilterFrameText;
      
      private var _actMissionInfoText:FilterFrameText;
      
      private var _emailMissionInfoText:FilterFrameText;
      
      private var _btNumBg0:ScaleFrameImage;
      
      private var _btNumBg1:ScaleFrameImage;
      
      public var interval:int;
      
      public function ExitAllButton()
      {
         super();
      }
      
      public function start() : void
      {
         _viewArr = [];
         _model = new ExitPromptModel();
         _dayMissionBt = ComponentFactory.Instance.creat("ExitPromptFrame.dayMissionFontBt");
         _bullet1 = ComponentFactory.Instance.creat("asset.core.quest.QuestConditionBGHighlight1");
         _dayMissionInfoText = ComponentFactory.Instance.creat("ExitPromptFrame.BtInfoText");
         _dayMissionBt.addChild(_bullet1);
         _dayMissionBt.addChild(_dayMissionInfoText);
         _btNumBg0 = ComponentFactory.Instance.creatComponentByStylename("ExitPromptFrame.BtInfoImg");
         _btNumBg0.setFrame(1);
         _dayMissionBt.addChild(_btNumBg0);
         _dayMissionSprite = new MissionSprite(_model.list0Arr);
         _dayMissionSprite.visible = false;
         _actMissionBt = ComponentFactory.Instance.creat("ExitPromptFrame.actMissionFontBt");
         _bullet2 = ComponentFactory.Instance.creat("asset.core.quest.QuestConditionBGHighlight2");
         _actMissionBt.addChild(_bullet2);
         _actMissionInfoText = ComponentFactory.Instance.creat("ExitPromptFrame.BtInfoText");
         _actMissionBt.addChild(_actMissionInfoText);
         _actMissionSprite = new MissionSprite(_model.list1Arr);
         _actMissionSprite.visible = false;
         _btNumBg1 = ComponentFactory.Instance.creatComponentByStylename("ExitPromptFrame.BtInfoImg");
         _btNumBg1.setFrame(1);
         _actMissionBt.addChild(_btNumBg1);
         _emailMissionBt = ComponentFactory.Instance.creat("ExitPromptFrame.emailMissionFontBt");
         _bullet3 = ComponentFactory.Instance.creat("asset.core.quest.QuestConditionBGHighlight3");
         _emailMissionBt.addChild(_bullet3);
         _emailMissionInfoText = ComponentFactory.Instance.creat("ExitPromptFrame.BtInfoText");
         _emailMissionBt.addChild(_emailMissionInfoText);
         addChild(_dayMissionSprite);
         addChild(_actMissionSprite);
         addChild(_dayMissionBt);
         addChild(_actMissionBt);
         addChild(_emailMissionBt);
         _viewArr.push(_dayMissionBt);
         _viewArr.push(_dayMissionSprite);
         _viewArr.push(_actMissionBt);
         _viewArr.push(_actMissionSprite);
         _viewArr.push(_emailMissionBt);
         _addEvt();
         _order();
         if(_model.list0Arr.length > 0)
         {
            _dayMissionInfoText.htmlText = _textAnalyz0(LanguageMgr.GetTranslation("ddt.exitPrompt.btInfoTextI"),_model.list0Arr.length);
         }
         else
         {
            _btNumBg0.visible = false;
            _dayMissionInfoText.htmlText = LanguageMgr.GetTranslation("ddt.exitPrompt.btInfoTextII");
         }
         if(_model.list1Arr.length > 0)
         {
            _actMissionInfoText.htmlText = _textAnalyz0(LanguageMgr.GetTranslation("ddt.exitPrompt.btInfoTextI"),_model.list1Arr.length);
         }
         else
         {
            _btNumBg1.visible = false;
            _actMissionInfoText.htmlText = LanguageMgr.GetTranslation("ddt.exitPrompt.btInfoTextII");
         }
         if(_model.list2Num > 0)
         {
            _emailMissionInfoText.htmlText = _textAnalyz0(LanguageMgr.GetTranslation("ddt.exitPrompt.btInfoTextIII"),_model.list2Num);
         }
         else
         {
            _emailMissionInfoText.htmlText = LanguageMgr.GetTranslation("ddt.exitPrompt.btInfoTextIV");
         }
      }
      
      public function get needScorllBar() : Boolean
      {
         var boo:Boolean = true;
         if(_model.list0Arr.length + _model.list1Arr.length == 0)
         {
            boo = false;
         }
         return boo;
      }
      
      private function _order() : void
      {
         var i:int = 0;
         for(i = 1; i < _viewArr.length; )
         {
            if(_viewArr[i - 1].visible == false || _viewArr[i - 1].height == 0)
            {
               _viewArr[i].y = _viewArr[i - 2].y + _viewArr[i - 2].height + interval;
            }
            else if(_viewArr[i - 1] is MissionSprite)
            {
               _viewArr[i].y = _viewArr[i - 1].y + _viewArr[i - 1].height + -25 + interval;
            }
            else
            {
               _viewArr[i].y = _viewArr[i - 1].y + _viewArr[i - 1].height + interval;
            }
            i++;
         }
         this.dispatchEvent(new Event("change"));
      }
      
      override public function get height() : Number
      {
         return _viewArr[_viewArr.length - 1].y + _viewArr[_viewArr.length - 1].height;
      }
      
      private function _addEvt() : void
      {
         _dayMissionBt.addEventListener("click",_clickDayBt);
         _actMissionBt.addEventListener("click",_clickActBt);
      }
      
      private function _clickDayBt(e:MouseEvent = null) : void
      {
         if(e != null)
         {
            SoundManager.instance.play("008");
         }
         if(_dayMissionSprite.content.length == 0)
         {
            return;
         }
         if(_dayMissionSprite.visible == false)
         {
            _btNumBg0.setFrame(2);
            _dayMissionSprite.visible = true;
         }
         else
         {
            _btNumBg0.setFrame(1);
            _dayMissionSprite.visible = false;
         }
         _order();
      }
      
      private function _clickActBt(e:MouseEvent = null) : void
      {
         if(e != null)
         {
            SoundManager.instance.play("008");
         }
         if(_actMissionSprite.content.length == 0)
         {
            return;
         }
         if(_actMissionSprite.visible == false)
         {
            _btNumBg1.setFrame(2);
            _actMissionSprite.visible = true;
         }
         else
         {
            _btNumBg1.setFrame(1);
            _actMissionSprite.visible = false;
         }
         _order();
      }
      
      private function _textAnalyz0(str:String, num:int) : String
      {
         return str.replace(/r/g," " + String(num) + " ");
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(_dayMissionBt)
         {
            ObjectUtils.disposeObject(_dayMissionBt);
         }
         if(_dayMissionSprite)
         {
            ObjectUtils.disposeObject(_dayMissionSprite);
         }
         if(_actMissionBt)
         {
            ObjectUtils.disposeObject(_actMissionBt);
         }
         if(_actMissionSprite)
         {
            ObjectUtils.disposeObject(_actMissionSprite);
         }
         if(_emailMissionBt)
         {
            ObjectUtils.disposeObject(_emailMissionBt);
         }
         if(_dayMissionInfoText)
         {
            ObjectUtils.disposeObject(_dayMissionInfoText);
         }
         if(_actMissionInfoText)
         {
            ObjectUtils.disposeObject(_actMissionInfoText);
         }
         if(_emailMissionInfoText)
         {
            ObjectUtils.disposeObject(_emailMissionInfoText);
         }
         if(_bullet1)
         {
            ObjectUtils.disposeObject(_bullet1);
         }
         if(_bullet2)
         {
            ObjectUtils.disposeObject(_bullet2);
         }
         if(_bullet3)
         {
            ObjectUtils.disposeObject(_bullet3);
         }
         if(_btNumBg0)
         {
            ObjectUtils.disposeObject(_btNumBg0);
         }
         if(_btNumBg1)
         {
            ObjectUtils.disposeObject(_btNumBg1);
         }
         _dayMissionBt = null;
         _dayMissionSprite = null;
         _actMissionBt = null;
         _actMissionSprite = null;
         _emailMissionBt = null;
         _dayMissionInfoText = null;
         _actMissionInfoText = null;
         _emailMissionInfoText = null;
         _bullet1 = null;
         _bullet2 = null;
         _bullet3 = null;
         _btNumBg0 = null;
         _btNumBg1 = null;
      }
   }
}
