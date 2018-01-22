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
      
      public function QuestionSelectViewBase(param1:QuestionDataBaseInfo)
      {
         super(param1);
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
         var _loc2_:* = null;
         var _loc1_:int = 0;
         if(_list == null)
         {
            _scrollPanel.visible = false;
         }
         if(_list.width <= 212)
         {
            _loc1_ = 157;
         }
         else if(_list.width >= 380)
         {
            _loc1_ = -16;
         }
         else
         {
            _loc1_ = 369 - _list.width - 10;
         }
         _loc2_ = "21," + _loc1_ + ",0, -8, 3";
         _scrollPanel.vScrollbarInnerRectString = _loc2_;
         _scrollPanel.invalidateViewport();
      }
      
      protected function createItem() : void
      {
         var _loc2_:* = null;
         if(_list == null)
         {
            _list = ComponentFactory.Instance.creatComponentByStylename("questionAward.singleSelect.vBox");
            addChild(_list);
         }
         var _loc1_:Vector.<String> = _info.getContent();
         while(_loc1_.length > 0)
         {
            _loc2_ = _loc1_.shift();
            _list.addChild(createCheckBox(_loc2_));
         }
      }
      
      protected function createCheckBox(param1:String) : SelectedCheckButton
      {
         _checkBtn = ComponentFactory.Instance.creatComponentByStylename("questionAward.singleSelectBtn");
         _checkBtn.text = param1;
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
