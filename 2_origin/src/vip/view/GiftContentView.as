package vip.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   
   public class GiftContentView extends Sprite implements Disposeable
   {
       
      
      private var listLen:int = 12;
      
      private var _content:VBox;
      
      private var _scrollPanel:ScrollPanel;
      
      public function GiftContentView()
      {
         super();
         initData();
         initView();
      }
      
      private function initData() : void
      {
      }
      
      private function initView() : void
      {
         var i:int = 0;
         var giftItem:* = null;
         _content = ComponentFactory.Instance.creatComponentByStylename("vip.GiftContentView.Vbox");
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("vip.GiftContentView.DetailList");
         _scrollPanel.setView(_content);
         for(i = 0; i <= listLen - 1; )
         {
            giftItem = new VipGiftDetail();
            giftItem.setData(i + 1);
            _content.addChild(giftItem);
            i++;
         }
         _scrollPanel.invalidateViewport();
         addChild(_scrollPanel);
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_content);
         _content = null;
         ObjectUtils.disposeObject(_scrollPanel);
         _scrollPanel = null;
      }
   }
}
