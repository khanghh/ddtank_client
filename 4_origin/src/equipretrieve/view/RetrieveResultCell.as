package equipretrieve.view
{
   import bagAndInfo.cell.DragEffect;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import store.StoreCell;
   
   public class RetrieveResultCell extends StoreCell
   {
      
      public static const SHINE_XY:int = 5;
      
      public static const SHINE_SIZE:int = 76;
       
      
      private var bg:Sprite;
      
      private var bgBit:Bitmap;
      
      private var _text:FilterFrameText;
      
      public function RetrieveResultCell(param1:int)
      {
         bg = new Sprite();
         bgBit = ComponentFactory.Instance.creatBitmap("equipretrieve.trieveCell1");
         _text = ComponentFactory.Instance.creatComponentByStylename("ddtbagAndInfo.reworkname.Text1");
         _text.text = LanguageMgr.GetTranslation("store.Fusion.FusionCellText");
         bg.addChild(bgBit);
         bg.addChild(_text);
         super(bg,param1);
      }
      
      override public function startShine() : void
      {
         _shiner.x = 5;
         _shiner.y = 5;
         var _loc1_:int = 76;
         _shiner.height = _loc1_;
         _shiner.width = _loc1_;
         super.startShine();
      }
      
      override protected function createChildren() : void
      {
         super.createChildren();
         if(_tbxCount)
         {
            ObjectUtils.disposeObject(_tbxCount);
         }
         _tbxCount = ComponentFactory.Instance.creat("equipretrieve.goodsCountTextII");
         _tbxCount.mouseEnabled = false;
         addChild(_tbxCount);
      }
      
      override public function dragDrop(param1:DragEffect) : void
      {
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(bgBit)
         {
            ObjectUtils.disposeObject(bgBit);
         }
         if(_text)
         {
            ObjectUtils.disposeObject(_text);
         }
         if(bg)
         {
            ObjectUtils.disposeObject(bg);
         }
         if(_tbxCount)
         {
            ObjectUtils.disposeObject(_tbxCount);
         }
         bgBit = null;
         bg = null;
         _tbxCount = null;
         _text = null;
      }
   }
}
