package gradeBuy.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ListPanel;
   import com.pickgliss.ui.controls.container.GridBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.TimeManager;
   import flash.display.Sprite;
   import gradeBuy.GradeBuyController;
   import gradeBuy.GradeBuyManager;
   
   public class GradeBuyRewardTypeView extends Sprite implements Disposeable
   {
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _scrollPanel:ListPanel;
      
      private var _typeItemContainer:GridBox;
      
      public function GradeBuyRewardTypeView()
      {
         super();
         init();
      }
      
      private function init() : void
      {
         _bg = ComponentFactory.Instance.creat("gradeBuy.typeView.bg.scale9cornerImage");
         addChild(_bg);
         _typeItemContainer = new GridBox();
         _typeItemContainer.columnNumber = 4;
         _typeItemContainer.spacing = 11;
         _typeItemContainer.align = "left";
         _typeItemContainer.x = -10;
         addChild(_typeItemContainer);
      }
      
      public function update() : void
      {
         var _loc4_:int = 0;
         var _loc2_:Array = GradeBuyManager.getInstance().data;
         _typeItemContainer.removeAllChild();
         var _loc1_:Array = [];
         var _loc3_:int = _loc2_.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            if(_loc2_[_loc4_]["date"] - TimeManager.Instance.Now().time > 0)
            {
               _loc1_.push(_loc2_[_loc4_]);
            }
            _loc4_++;
         }
         GradeBuyManager.getInstance().data = _loc1_;
         _loc3_ = _loc1_.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _typeItemContainer.addChild(new GradeBuyTypeItem(_loc1_[_loc4_]));
            _loc4_++;
         }
         if(_typeItemContainer.numChildren == 0)
         {
            GradeBuyController.getInstance().hideTypeView();
            return;
         }
         _typeItemContainer.arrange();
         _bg.height = Math.ceil(_loc3_ / _typeItemContainer.columnNumber) * 115;
      }
      
      public function arrage() : void
      {
         _typeItemContainer.arrange();
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
         _bg = null;
         _scrollPanel = null;
         _typeItemContainer = null;
      }
   }
}
