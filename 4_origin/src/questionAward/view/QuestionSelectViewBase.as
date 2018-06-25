package questionAward.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.utils.ObjectUtils;
   import questionAward.data.QuestionDataBaseInfo;
   
   public class QuestionSelectViewBase extends QuestionViewBase
   {
       
      
      protected var _checkBtn:SelectedCheckButton;
      
      protected var _list:VBox;
      
      private var _scrollPanel:ScrollPanel;
      
      public function QuestionSelectViewBase(value:QuestionDataBaseInfo)
      {
         super(value);
      }
      
      override protected function initView() : void
      {
         super.initView();
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("questionAward.itemSelectvBox.scrollPanel");
         _list = ComponentFactory.Instance.creatComponentByStylename("questionAward.singleSelect.vBox");
         addChild(_list);
         _scrollPanel.setView(_list);
         addChild(_scrollPanel);
         createItem();
         updateScrollBar();
      }
      
      private function updateScrollBar() : void
      {
         var str:* = null;
         var temWidth:int = 0;
         if(_list == null)
         {
            _scrollPanel.visible = false;
         }
         if(_list.width <= 212)
         {
            temWidth = 157;
         }
         else if(_list.width >= 380)
         {
            temWidth = -16;
         }
         else
         {
            temWidth = 369 - _list.width - 10;
         }
         str = "21," + temWidth + ",0, -8, 3";
         _scrollPanel.vScrollbarInnerRectString = str;
         _scrollPanel.invalidateViewport();
      }
      
      protected function createItem() : void
      {
         var temStr:* = null;
         if(_list == null)
         {
            _list = ComponentFactory.Instance.creatComponentByStylename("questionAward.singleSelect.vBox");
            addChild(_list);
         }
         var contentList:Vector.<String> = _info.getContent();
         while(contentList.length > 0)
         {
            temStr = contentList.shift();
            _list.addChild(createCheckBox(temStr));
         }
      }
      
      protected function createCheckBox(name:String) : SelectedCheckButton
      {
         _checkBtn = ComponentFactory.Instance.creatComponentByStylename("questionAward.singleSelectBtn");
         _checkBtn.text = name;
         return _checkBtn;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(_checkBtn)
         {
            ObjectUtils.disposeObject(_checkBtn);
         }
         _checkBtn = null;
         if(_list)
         {
            ObjectUtils.disposeAllChildren(_list);
            ObjectUtils.disposeObject(_checkBtn);
            _checkBtn = null;
         }
      }
   }
}
