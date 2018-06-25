package guardCore.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.tip.BaseTip;
   import com.pickgliss.utils.ObjectUtils;
   import guardCore.data.GuardCoreInfo;
   
   public class GuardCoreBuffTips extends BaseTip
   {
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _vBox:VBox;
      
      public function GuardCoreBuffTips()
      {
         super();
      }
      
      override protected function init() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("core.guardCoreGameTips.Bg");
         addChild(_bg);
         _vBox = ComponentFactory.Instance.creatComponentByStylename("core.guardCoreGameTips.VBox");
         addChild(_vBox);
         super.init();
      }
      
      private function updateView() : void
      {
         var i:int = 0;
         var item:* = null;
         _vBox.disposeAllChildren();
         var list:Array = _tipData as Array;
         for(i = 0; i < list.length; )
         {
            item = new GuardCoreBuffTipsItem(list[i] as GuardCoreInfo);
            _vBox.addChild(item);
            i++;
         }
         var _loc4_:* = _vBox.width + _vBox.x * 2;
         _bg.width = _loc4_;
         this.width = _loc4_;
         _loc4_ = _vBox.height + _vBox.y * 2;
         _bg.height = _loc4_;
         this.height = _loc4_;
      }
      
      override public function set tipData(value:Object) : void
      {
         _tipData = value;
         updateView();
      }
      
      override public function get tipData() : Object
      {
         return _tipData;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_vBox);
         _vBox = null;
         super.dispose();
      }
   }
}
