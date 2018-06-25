package ddt.view.vote
{
   import com.pickgliss.events.ListItemEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ComboBox;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.list.VectorListModel;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.SoundManager;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class VoteSelectItem extends Sprite implements Disposeable
   {
       
      
      private var _item:SelectedCheckButton;
      
      private var _textTxt:FilterFrameText;
      
      private var _scoreCombox:ComboBox;
      
      private var _scoreArr:Array;
      
      private var _currentScore:int;
      
      private var _text:String;
      
      private var _type:int;
      
      private var _otherSelect:Boolean;
      
      private var _inputTxt:FilterFrameText;
      
      private var _inputBg:Scale9CornerImage;
      
      private var _voteInfo:VoteInfo;
      
      public function VoteSelectItem(type:int, voteInfo:VoteInfo, otherSelect:Boolean = false)
      {
         _scoreArr = [1,2,3,4,5,6,7,8,9,10];
         super();
         _type = type;
         _voteInfo = voteInfo;
         _otherSelect = otherSelect;
         initView();
      }
      
      private function initView() : void
      {
         if(_type == 1)
         {
            _item = ComponentFactory.Instance.creatComponentByStylename("vote.answer.selectedBtn");
            addChild(_item);
            if(_otherSelect)
            {
               _item.width = 93;
               _inputBg = ComponentFactory.Instance.creatComponentByStylename("vote.inputBg");
               addChild(_inputBg);
               _inputTxt = ComponentFactory.Instance.creatComponentByStylename("vote.otherSelect.inputTxt");
               _inputTxt.maxChars = 60;
               _inputTxt.mouseEnabled = false;
               addChild(_inputTxt);
            }
         }
         else if(_type == 2)
         {
            _textTxt = ComponentFactory.Instance.creatComponentByStylename("vote.answerTxt");
            addChild(_textTxt);
            _textTxt.x = 23;
            _textTxt.y = 7;
            _scoreCombox = ComponentFactory.Instance.creatComponentByStylename("vote.scoreCombo");
            _scoreCombox.selctedPropName = "text";
            _scoreCombox.textField.text = "";
            addChild(_scoreCombox);
            updateComboBox();
         }
      }
      
      public function initEvent() : void
      {
         if(_type == 1)
         {
            _item.addEventListener("click",__playSound);
         }
         else if(_type == 2)
         {
            _scoreCombox.listPanel.list.addEventListener("listItemClick",__onListClick);
         }
      }
      
      protected function __onListClick(event:ListItemEvent) : void
      {
         SoundManager.instance.play("008");
         _currentScore = event.cellValue;
         updateComboBox(event.cellValue);
      }
      
      private function updateComboBox(obj:* = null) : void
      {
         var comboxModel:VectorListModel = _scoreCombox.listPanel.vectorListModel;
         comboxModel.clear();
         comboxModel.appendAll(_scoreArr);
         comboxModel.remove(obj);
      }
      
      private function __playSound(evt:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(_type == 1 && _otherSelect)
         {
            if(!_item.selected)
            {
               inputEnable = false;
            }
            else
            {
               inputEnable = true;
            }
         }
      }
      
      public function set inputEnable(value:Boolean) : void
      {
         if(_type == 1 && _otherSelect)
         {
            _inputTxt.mouseEnabled = value;
         }
      }
      
      private function removeEvent() : void
      {
         if(_type == 1)
         {
            _item.removeEventListener("click",__playSound);
         }
         else if(_type == 2)
         {
            _scoreCombox.listPanel.list.removeEventListener("listItemClick",__onListClick);
         }
      }
      
      public function get selected() : Boolean
      {
         if(_type == 1)
         {
            return _item.selected;
         }
         return true;
      }
      
      public function get selectedAnswer() : String
      {
         return "";
      }
      
      public function get item() : SelectedCheckButton
      {
         return _item;
      }
      
      public function get otherSelect() : Boolean
      {
         return _otherSelect;
      }
      
      public function get answerId() : String
      {
         return _voteInfo.answerId;
      }
      
      public function get score() : int
      {
         return _currentScore;
      }
      
      public function get content() : String
      {
         return _inputTxt.text;
      }
      
      public function set text(value:String) : void
      {
         if(_type == 1)
         {
            _item.text = value;
         }
         else if(_type == 2)
         {
            _textTxt.text = value;
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_item);
         _item = null;
         ObjectUtils.disposeObject(_scoreCombox);
         _scoreCombox = null;
         ObjectUtils.disposeObject(_textTxt);
         _textTxt = null;
         ObjectUtils.disposeObject(_inputTxt);
         _inputTxt = null;
         ObjectUtils.disposeObject(_inputBg);
         _inputBg = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
