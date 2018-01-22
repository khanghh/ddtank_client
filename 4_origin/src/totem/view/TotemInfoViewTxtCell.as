package totem.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import totem.TotemManager;
   import totem.data.TotemAddInfo;
   
   public class TotemInfoViewTxtCell extends Sprite implements Disposeable
   {
       
      
      private var _nameTxt:FilterFrameText;
      
      private var _valueTxt:FilterFrameText;
      
      private var _txtArray:Array;
      
      private var _bg:Bitmap;
      
      public function TotemInfoViewTxtCell()
      {
         super();
         _bg = ComponentFactory.Instance.creatBitmap("asset.totem.infoView.txtCellBg");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("totem.infoView.propertyName.txt");
         _valueTxt = ComponentFactory.Instance.creatComponentByStylename("totem.infoView.propertyValue.txt");
         var _loc1_:String = LanguageMgr.GetTranslation("ddt.totem.sevenProperty");
         _txtArray = _loc1_.split(",");
         addChild(_bg);
         addChild(_nameTxt);
         addChild(_valueTxt);
      }
      
      public function show(param1:int, param2:int) : void
      {
         _nameTxt.text = _txtArray[param1 - 1];
         var _loc3_:TotemAddInfo = TotemManager.instance.getAddInfo(param2);
         switch(int(param1) - 1)
         {
            case 0:
               _valueTxt.text = _loc3_.Attack.toString();
               break;
            case 1:
               _valueTxt.text = _loc3_.Defence.toString();
               break;
            case 2:
               _valueTxt.text = _loc3_.Agility.toString();
               break;
            case 3:
               _valueTxt.text = _loc3_.Luck.toString();
               break;
            case 4:
               _valueTxt.text = _loc3_.Blood.toString();
               break;
            case 5:
               _valueTxt.text = _loc3_.Damage.toString();
               break;
            case 6:
               _valueTxt.text = _loc3_.Guard.toString();
         }
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
         _nameTxt = null;
         _valueTxt = null;
         _bg = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
