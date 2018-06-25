package wantstrong.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.PlayerManager;
   import flash.display.Sprite;
   import wantstrong.data.WantStrongMenuData;
   
   public class WantStrongContentView extends Sprite implements Disposeable
   {
       
      
      private var _content:VBox;
      
      private var _detail:WantStrongDetail;
      
      private var _scrollPanel:ScrollPanel;
      
      public function WantStrongContentView()
      {
         super();
         initUI();
         initEvent();
      }
      
      private function initEvent() : void
      {
      }
      
      private function initUI() : void
      {
         _content = ComponentFactory.Instance.creatComponentByStylename("wantstrong.ActivityState.Vbox");
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("wantstrong.ActivityDetailList");
         _scrollPanel.setView(_content);
         addChild(_scrollPanel);
      }
      
      public function setData(val:* = null) : void
      {
         var wantStrongDetail:* = null;
         var _loc5_:int = 0;
         var _loc4_:* = val;
         for each(var item in val)
         {
            if(PlayerManager.Instance.Self.Grade >= item.needLevel)
            {
               wantStrongDetail = ComponentFactory.Instance.creatCustomObject("wantstrong.WantStrongDetail",[item]);
               _content.addChild(wantStrongDetail);
            }
         }
         _scrollPanel.invalidateViewport();
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
