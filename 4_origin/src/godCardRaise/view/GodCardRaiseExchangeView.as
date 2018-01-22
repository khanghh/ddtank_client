package godCardRaise.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.utils.PositionUtils;
   import flash.display.Sprite;
   import godCardRaise.GodCardRaiseManager;
   
   public class GodCardRaiseExchangeView extends Sprite implements Disposeable
   {
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _leftView:GodCardRaiseExchangeLeftView;
      
      private var _rightView:GodCardRaiseExchangeRightView;
      
      public function GodCardRaiseExchangeView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("godCardRaiseExchangeView.bg");
         addChild(_bg);
         _leftView = new GodCardRaiseExchangeLeftView();
         PositionUtils.setPos(_leftView,"godCardRaiseExchangeView.godCardRaiseExchangeLeftViewPos");
         addChild(_leftView);
         _rightView = new GodCardRaiseExchangeRightView();
         PositionUtils.setPos(_rightView,"godCardRaiseExchangeView.godCardRaiseExchangeRightViewPos");
         addChild(_rightView);
         _leftView.setData(GodCardRaiseManager.Instance.godCardListGroupInfoList,_rightView.changeView);
      }
      
      public function updateView() : void
      {
         if(_leftView)
         {
            _leftView.updateView();
         }
         if(_rightView)
         {
            _rightView.updateView();
         }
      }
      
      private function initEvent() : void
      {
      }
      
      private function removeEvent() : void
      {
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         _bg = null;
         _leftView = null;
         _rightView = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
