package ddt.view.vote
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.vote.VoteQuestionInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SoundManager;
   import ddt.manager.VoteManager;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.MouseEvent;
   
   public class VoteView extends Frame
   {
      
      public static var OK_CLICK:String = "Ok_click";
      
      public static var VOTEVIEW_CLOSE:String = "voteView_close";
      
      private static var CELL_1_GOODS:int = 11904;
      
      private static var CELL_2_GOODS:int = 11032;
      
      private static var TWOLINEHEIGHT:int = 31;
      
      private static var questionBGHeight_2line:int = 188;
      
      private static var questionBGY_2line:int = 143;
      
      private static var questionContentY_2line:int = 158;
      
      private static const NUMBER:int = 2;
       
      
      private var _voteInfo:VoteQuestionInfo;
      
      private var _choseAnswerID:int;
      
      private var _itemArr:Vector.<VoteSelectItem>;
      
      private var _answerGroup:SelectedButtonGroup;
      
      private var _okBtn:TextButton;
      
      private var _answerBG:ScaleBitmapImage;
      
      private var _questionContent:FilterFrameText;
      
      private var _voteProgress:FilterFrameText;
      
      private var _selectSp:Sprite;
      
      private var _bg:ScaleBitmapImage;
      
      private var _itemList:SimpleTileList;
      
      private var _inputTxt:FilterFrameText;
      
      private var _defaultInputTxt:FilterFrameText;
      
      private var panel:ScrollPanel;
      
      public function VoteView()
      {
         super();
         addEvent();
      }
      
      public function get choseAnswerID() : int
      {
         return _choseAnswerID;
      }
      
      override protected function init() : void
      {
         super.init();
         _itemArr = new Vector.<VoteSelectItem>();
         escEnable = true;
         titleText = LanguageMgr.GetTranslation("ddt.view.vote.title");
         _bg = ComponentFactory.Instance.creatComponentByStylename("vote.VoteView.bg");
         _answerBG = ComponentFactory.Instance.creatComponentByStylename("vote.answerBG");
         _questionContent = ComponentFactory.Instance.creat("vote.questionContent");
         _voteProgress = ComponentFactory.Instance.creat("vote.progress");
         _okBtn = ComponentFactory.Instance.creatComponentByStylename("vote.okBtn");
         _selectSp = new Sprite();
         _itemList = ComponentFactory.Instance.creatCustomObject("vote.itemList",[2]);
         panel = ComponentFactory.Instance.creatComponentByStylename("vote.vote.VoteanswerPanel");
         panel.setView(_itemList);
         addToContent(_bg);
         addToContent(_okBtn);
         _selectSp.x = -4;
         _selectSp.y = 58;
         _selectSp.addChild(_answerBG);
         _selectSp.addChild(_questionContent);
         _selectSp.addChild(_voteProgress);
         _selectSp.addChild(panel);
         addToContent(_selectSp);
         _okBtn.text = LanguageMgr.GetTranslation("ok");
      }
      
      public function set info(voteInfo:VoteQuestionInfo) : void
      {
         _voteInfo = voteInfo;
         if(_voteInfo.questionType == 1)
         {
            _itemList.hSpace = 60;
         }
         else if(_voteInfo.questionType == 2)
         {
            _itemList.hSpace = 10;
         }
         update();
      }
      
      private function update() : void
      {
         var j:int = 0;
         var otherSelect:Boolean = false;
         var item:* = null;
         clear();
         _voteProgress.text = "进度" + VoteManager.Instance.count + "/" + VoteManager.Instance.questionLength;
         if(_voteInfo.questionType == 1)
         {
            if(_voteInfo.multiple)
            {
               _answerGroup = new SelectedButtonGroup(true,_voteInfo.answerLength);
            }
            else
            {
               _answerGroup = new SelectedButtonGroup();
            }
            _answerGroup.addEventListener("change",__changeHandler);
         }
         _itemArr = new Vector.<VoteSelectItem>();
         var index:int = 0;
         _questionContent.text = "    " + _voteInfo.question;
         if(_voteInfo.questionType != 3)
         {
            for(j = 0; j < _voteInfo.answer.length; )
            {
               index++;
               if(_voteInfo.questionType == 1 && _voteInfo.otherSelect && j == _voteInfo.answer.length - 1)
               {
                  otherSelect = true;
               }
               item = new VoteSelectItem(_voteInfo.questionType,_voteInfo.answer[j],otherSelect);
               item.text = index + ". " + _voteInfo.answer[j].answer;
               _itemList.addChild(item);
               _itemArr.push(item);
               if(_voteInfo.questionType == 1)
               {
                  _answerGroup.addSelectItem(item.item);
               }
               item.initEvent();
               j++;
            }
         }
         else
         {
            _inputTxt = ComponentFactory.Instance.creatComponentByStylename("vote.inputTxt");
            _inputTxt.maxChars = 500;
            _defaultInputTxt = ComponentFactory.Instance.creatComponentByStylename("vote.inputTxt");
            _defaultInputTxt.text = LanguageMgr.GetTranslation("ddt.view.vote.defaultTxt");
            _selectSp.addChild(_inputTxt);
            _selectSp.addChild(_defaultInputTxt);
            _inputTxt.setFocus();
            _inputTxt.addEventListener("change",__inputChangeHandler);
            _inputTxt.addEventListener("focusIn",__searchInputFocusIn);
            _inputTxt.addEventListener("focusOut",__searchInputFocusOut);
         }
         panel.invalidateViewport();
      }
      
      private function __playSound(evt:Event) : void
      {
         SoundManager.instance.play("008");
      }
      
      private function clear() : void
      {
         var i:int = 0;
         _questionContent.text = "";
         _voteProgress.text = "";
         if(_answerGroup)
         {
            _answerGroup.removeEventListener("change",__changeHandler);
            _answerGroup.dispose();
            _answerGroup = null;
         }
         ObjectUtils.disposeObject(_inputTxt);
         _inputTxt = null;
         for(i = 0; i < _itemArr.length; )
         {
            _itemArr[i].dispose();
            _itemArr[i] = null;
            i++;
         }
         _itemArr = null;
         if(_itemList)
         {
            _itemList.removeAllChild();
         }
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__responseHandler);
         _okBtn.addEventListener("click",__clickHandler);
      }
      
      protected function __inputChangeHandler(event:Event) : void
      {
         ObjectUtils.disposeObject(_defaultInputTxt);
         _defaultInputTxt = null;
         _inputTxt.removeEventListener("change",__inputChangeHandler);
      }
      
      protected function __searchInputFocusIn(event:FocusEvent) : void
      {
         ObjectUtils.disposeObject(_defaultInputTxt);
         _defaultInputTxt = null;
         _inputTxt.removeEventListener("change",__inputChangeHandler);
         if(_inputTxt.text == LanguageMgr.GetTranslation("ddt.view.vote.defaultTxt"))
         {
            _inputTxt.text = "";
         }
      }
      
      protected function __searchInputFocusOut(event:FocusEvent) : void
      {
         ObjectUtils.disposeObject(_defaultInputTxt);
         _defaultInputTxt = null;
         _inputTxt.removeEventListener("change",__inputChangeHandler);
         if(_inputTxt.text.length == 0)
         {
            _inputTxt.text = LanguageMgr.GetTranslation("ddt.view.vote.defaultTxt");
         }
      }
      
      protected function __changeHandler(event:Event) : void
      {
         if(_itemArr[_itemArr.length - 1].item.selected)
         {
            _itemArr[_itemArr.length - 1].inputEnable = true;
         }
         else
         {
            _itemArr[_itemArr.length - 1].inputEnable = false;
         }
      }
      
      private function __clickHandler(evt:MouseEvent) : void
      {
         var i:int = 0;
         SoundManager.instance.play("008");
         var hasChosed:Boolean = false;
         if(_voteInfo.questionType == 1)
         {
            var _loc7_:int = 0;
            var _loc6_:* = _itemArr;
            for each(var item in _itemArr)
            {
               if(item.otherSelect && item.selected)
               {
                  if(item.content == "")
                  {
                     MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.view.vote.choseOne3"));
                     return;
                  }
                  hasChosed = true;
                  break;
               }
            }
            if(!hasChosed)
            {
               for(i = 0; i < _itemArr.length; )
               {
                  if(_itemArr[i].selected)
                  {
                     hasChosed = true;
                     break;
                  }
                  i++;
               }
            }
         }
         else if(_voteInfo.questionType == 2)
         {
            hasChosed = true;
            var _loc9_:int = 0;
            var _loc8_:* = _itemArr;
            for each(var item2 in _itemArr)
            {
               if(item2.score == 0)
               {
                  hasChosed = false;
                  break;
               }
            }
         }
         else if(_inputTxt && _inputTxt.text != LanguageMgr.GetTranslation("ddt.view.vote.defaultTxt") && _inputTxt.text.length > 0)
         {
            hasChosed = true;
         }
         if(!hasChosed)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.view.vote.choseOne" + _voteInfo.questionType));
            return;
         }
         dispatchEvent(new Event(OK_CLICK));
      }
      
      public function get selectAnswer() : String
      {
         var i:int = 0;
         var item:* = null;
         var str:String = _voteInfo.questionType + "|";
         if(_voteInfo.questionType != 3)
         {
            for(i = 0; i < _itemArr.length; )
            {
               item = _itemArr[i];
               if(item.selected)
               {
                  switch(int(_voteInfo.questionType) - 1)
                  {
                     case 0:
                        if(item.otherSelect)
                        {
                           str = str + item.answerId + "," + item.content + "|";
                        }
                        else
                        {
                           str = str + item.answerId + "|";
                        }
                        break;
                     case 1:
                        str = str + item.answerId + "," + item.score + "|";
                  }
               }
               i++;
            }
         }
         else
         {
            str = str + _voteInfo.questionID + "," + _inputTxt.text + "|";
         }
         return str;
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__responseHandler);
         _okBtn.removeEventListener("click",__clickHandler);
         if(_inputTxt)
         {
            _inputTxt.removeEventListener("change",__inputChangeHandler);
            _inputTxt.removeEventListener("focusIn",__searchInputFocusIn);
            _inputTxt.removeEventListener("focusOut",__searchInputFocusOut);
         }
      }
      
      private function __responseHandler(evt:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(evt.responseCode))
         {
            case 0:
            case 1:
               dispose();
               dispatchEvent(new Event(VOTEVIEW_CLOSE));
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         clear();
         super.dispose();
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(_answerBG)
         {
            ObjectUtils.disposeObject(_answerBG);
         }
         _answerBG = null;
         if(_answerGroup)
         {
            ObjectUtils.disposeObject(_answerGroup);
         }
         _answerGroup = null;
         if(_okBtn)
         {
            ObjectUtils.disposeObject(_okBtn);
         }
         _okBtn = null;
         if(_questionContent)
         {
            ObjectUtils.disposeObject(_questionContent);
         }
         _questionContent = null;
         if(_voteProgress)
         {
            ObjectUtils.disposeObject(_voteProgress);
         }
         _voteProgress = null;
         ObjectUtils.disposeObject(_inputTxt);
         _inputTxt = null;
         ObjectUtils.disposeObject(_defaultInputTxt);
         _defaultInputTxt = null;
         ObjectUtils.disposeObject(_selectSp);
         _selectSp = null;
         ObjectUtils.disposeObject(_itemList);
         _itemList = null;
         ObjectUtils.disposeObject(panel);
         panel = null;
         _voteInfo = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
