package totem.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import flash.display.Sprite;
   import totem.TotemManager;
   import totem.data.TotemAddInfo;
   
   public class TotemRightViewTxtTxtCell extends Sprite implements Disposeable
   {
       
      
      private var _leftTxt:FilterFrameText;
      
      private var _rightTxt:FilterFrameText;
      
      private var _txtArray:Array;
      
      private var _type:int;
      
      public function TotemRightViewTxtTxtCell()
      {
         super();
         _leftTxt = ComponentFactory.Instance.creatComponentByStylename("totem.rightView.txtCell.leftTxt");
         _rightTxt = ComponentFactory.Instance.creatComponentByStylename("totem.rightView.txtCell.rightTxt");
         var _loc1_:String = LanguageMgr.GetTranslation("ddt.totem.sevenProperty");
         _txtArray = _loc1_.split(",");
         addChild(_leftTxt);
         addChild(_rightTxt);
      }
      
      public function show(param1:int) : void
      {
         _leftTxt.text = _txtArray[param1 - 1] + "：";
         _type = param1;
         refresh();
      }
      
      public function refresh() : void
      {
         var _loc1_:TotemAddInfo = TotemManager.instance.getAddInfo(TotemManager.instance.getTotemPointLevel(PlayerManager.Instance.Self.totemId));
         switch(int(_type) - 1)
         {
            case 0:
               _rightTxt.text = _loc1_.Attack.toString();
               break;
            case 1:
               _rightTxt.text = _loc1_.Defence.toString();
               break;
            case 2:
               _rightTxt.text = _loc1_.Agility.toString();
               break;
            case 3:
               _rightTxt.text = _loc1_.Luck.toString();
               break;
            case 4:
               _rightTxt.text = _loc1_.Blood.toString();
               break;
            case 5:
               _rightTxt.text = _loc1_.Damage.toString();
               break;
            case 6:
               _rightTxt.text = _loc1_.Guard.toString();
         }
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
         _leftTxt = null;
         _rightTxt = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
