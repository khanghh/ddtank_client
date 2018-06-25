package totem.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import flash.display.Sprite;
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
         var tmp:String = LanguageMgr.GetTranslation("ddt.totem.sevenProperty");
         _txtArray = tmp.split(",");
         addChild(_leftTxt);
         addChild(_rightTxt);
      }
      
      public function show(type:int) : void
      {
         _leftTxt.text = _txtArray[type - 1] + "：";
         _type = type;
      }
      
      public function refresh(info:TotemAddInfo) : void
      {
         var addInfo:* = info;
         switch(int(_type) - 1)
         {
            case 0:
               _rightTxt.text = addInfo.Attack.toString();
               break;
            case 1:
               _rightTxt.text = addInfo.Defence.toString();
               break;
            case 2:
               _rightTxt.text = addInfo.Agility.toString();
               break;
            case 3:
               _rightTxt.text = addInfo.Luck.toString();
               break;
            case 4:
               _rightTxt.text = addInfo.Blood.toString();
               break;
            case 5:
               _rightTxt.text = addInfo.Damage.toString();
               break;
            case 6:
               _rightTxt.text = addInfo.Guard.toString();
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
