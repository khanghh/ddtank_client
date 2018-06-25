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
         var i:int = 0;
         var data:Array = GradeBuyManager.getInstance().data;
         _typeItemContainer.removeAllChild();
         var tempArr:Array = [];
         var len:int = data.length;
         for(i = 0; i < len; )
         {
            if(data[i]["date"] - TimeManager.Instance.Now().time > 0)
            {
               tempArr.push(data[i]);
            }
            i++;
         }
         GradeBuyManager.getInstance().data = tempArr;
         len = tempArr.length;
         for(i = 0; i < len; )
         {
            _typeItemContainer.addChild(new GradeBuyTypeItem(tempArr[i]));
            i++;
         }
         if(_typeItemContainer.numChildren == 0)
         {
            GradeBuyController.getInstance().hideTypeView();
            return;
         }
         _typeItemContainer.arrange();
         _bg.height = Math.ceil(len / _typeItemContainer.columnNumber) * 115;
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
