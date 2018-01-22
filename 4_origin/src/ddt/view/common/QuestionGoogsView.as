package ddt.view.common
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import ddt.data.QuestionInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.QuestionInfoMannager;
   import ddt.manager.SoundManager;
   import flash.events.MouseEvent;
   import trainer.view.QuestionItemView;
   
   public class QuestionGoogsView extends Frame
   {
       
      
      private var _choiceBg:ScaleBitmapImage;
      
      private var _questionText:FilterFrameText;
      
      private var _answersText:FilterFrameText;
      
      private var _explanationText:FilterFrameText;
      
      private var _txtAward:FilterFrameText;
      
      private var _imgBg:ScaleBitmapImage;
      
      private var _progressText:FilterFrameText;
      
      private var _list:VBox;
      
      private var _currentQuestion:QuestionInfo;
      
      private var _questionTotal:int;
      
      private var _questionCurrentNum:int;
      
      private var _correctQuestionNum:int;
      
      private var _questionCatalogID:int;
      
      private var _questionID:int;
      
      private var _nextBtn:SimpleBitmapButton;
      
      private var _itemArray:Array;
      
      private var _perKey:int;
      
      public function QuestionGoogsView()
      {
         super();
         initContent();
      }
      
      private function initContent() : void
      {
         titleText = LanguageMgr.GetTranslation("ddt.view.common.QuestionGoogsView.title");
         _imgBg = ComponentFactory.Instance.creatComponentByStylename("common.QuestionGoogsFrame.bg");
         addToContent(_imgBg);
         _choiceBg = ComponentFactory.Instance.creatComponentByStylename("common.QuestionGoogsFrame.choiceBg");
         addToContent(_choiceBg);
         _explanationText = ComponentFactory.Instance.creatComponentByStylename("common.QuestionGoogsFrame.explanationText");
         _explanationText.text = LanguageMgr.GetTranslation("ddt.view.common.QuestionGoogsView.questionDescription");
         addToContent(_explanationText);
         _questionText = ComponentFactory.Instance.creatComponentByStylename("common.QuestionGoogsFrame.questionText");
         addToContent(_questionText);
         _progressText = ComponentFactory.Instance.creat("common.QuestionGoogsFrame.progressText");
         addToContent(_progressText);
         _list = ComponentFactory.Instance.creatComponentByStylename("trainer.question.ItemList");
         addToContent(_list);
         initItem();
      }
      
      private function initItem() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _itemArray = [];
         _loc2_ = 0;
         while(_loc2_ < 4)
         {
            _loc1_ = new QuestionItemView();
            _loc1_.addEventListener("click",__itemClick);
            _loc1_.visible = false;
            _list.addChild(_loc1_);
            _itemArray.push(_loc1_);
            _loc2_++;
         }
      }
      
      private function __itemClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         QuestionInfoMannager.Instance.sendRespond((param1.target as QuestionItemView).index);
      }
      
      private function update() : void
      {
         _questionText.text = _currentQuestion.QuestionContent;
         _progressText.text = LanguageMgr.GetTranslation("ddt.view.common.QuestionGoogsView.questionCorrect") + String(_correctQuestionNum) + "/" + String(_questionTotal);
         updateItem();
      }
      
      private function updateItem() : void
      {
         if(_currentQuestion.Option1 != "")
         {
            _itemArray[0].visible = true;
            _itemArray[0].setData(1,_currentQuestion.Option1);
         }
         else
         {
            _itemArray[0].visible = false;
         }
         if(_currentQuestion.Option2 != "")
         {
            _itemArray[1].visible = true;
            _itemArray[1].setData(2,_currentQuestion.Option2);
         }
         else
         {
            _itemArray[1].visible = false;
         }
         if(_currentQuestion.Option3 != "")
         {
            _itemArray[2].visible = true;
            _itemArray[2].setData(3,_currentQuestion.Option3);
         }
         else
         {
            _itemArray[2].visible = false;
         }
         if(_currentQuestion.Option4 != "")
         {
            _itemArray[3].visible = true;
            _itemArray[3].setData(4,_currentQuestion.Option4);
         }
         else
         {
            _itemArray[3].visible = false;
         }
      }
      
      public function setQuestionInfo(param1:QuestionInfo, param2:int, param3:int, param4:int) : void
      {
         _currentQuestion = param1;
         _questionTotal = param2;
         _questionCurrentNum = param3;
         _correctQuestionNum = param4;
         update();
      }
      
      private function getPerKeyStr(param1:int) : String
      {
         switch(int(param1) - 1)
         {
            case 0:
               return "A";
            case 1:
               return "B";
            case 2:
               return "C";
            case 3:
               return "D";
         }
      }
      
      private function cleanItem() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _itemArray.length)
         {
            (_itemArray[_loc1_] as QuestionItemView).removeEventListener("click",__itemClick);
            (_itemArray[_loc1_] as QuestionItemView).dispose();
            _loc1_++;
         }
         _list.disposeAllChildren();
         _itemArray = [];
      }
      
      override public function dispose() : void
      {
         cleanItem();
         if(_choiceBg && _choiceBg.parent)
         {
            _choiceBg.parent.removeChild(_choiceBg);
            _choiceBg.dispose();
            _choiceBg = null;
         }
         if(_questionText && _questionText.parent)
         {
            _questionText.parent.removeChild(_questionText);
            _questionText.dispose();
            _questionText = null;
         }
         if(_answersText && _answersText.parent)
         {
            _answersText.parent.removeChild(_answersText);
            _answersText.dispose();
            _answersText = null;
         }
         if(_explanationText && _explanationText.parent)
         {
            _explanationText.parent.removeChild(_explanationText);
            _explanationText.dispose();
            _explanationText = null;
         }
         if(_imgBg && _imgBg.parent)
         {
            _imgBg.parent.removeChild(_imgBg);
            _imgBg.dispose();
            _imgBg = null;
         }
         if(_progressText && _progressText.parent)
         {
            _progressText.parent.removeChild(_progressText);
            _progressText.dispose();
            _progressText = null;
         }
         if(_list && _list.parent)
         {
            _list.parent.removeChild(_list);
            _list.dispose();
            _list = null;
         }
         super.dispose();
      }
   }
}
