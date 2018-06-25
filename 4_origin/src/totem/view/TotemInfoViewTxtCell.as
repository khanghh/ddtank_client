package totem.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.PlayerInfo;
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
      
      private var _playerInfo:PlayerInfo;
      
      public function TotemInfoViewTxtCell(info:PlayerInfo)
      {
         _playerInfo = info;
         super();
         _bg = ComponentFactory.Instance.creatBitmap("asset.totem.infoView.txtCellBg");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("totem.infoView.propertyName.txt");
         _valueTxt = ComponentFactory.Instance.creatComponentByStylename("totem.infoView.propertyValue.txt");
         var tmp:String = LanguageMgr.GetTranslation("ddt.totem.sevenProperty");
         _txtArray = tmp.split(",");
         addChild(_bg);
         addChild(_nameTxt);
         addChild(_valueTxt);
      }
      
      public function show(type:int, totemID:int) : void
      {
         _nameTxt.text = _txtArray[type - 1];
         var addInfo:TotemAddInfo = TotemManager.instance.otherPlayerTotemAllPro(totemID,_playerInfo.totemGrades);
         switch(int(type) - 1)
         {
            case 0:
               _valueTxt.text = addInfo.Attack.toString();
               break;
            case 1:
               _valueTxt.text = addInfo.Defence.toString();
               break;
            case 2:
               _valueTxt.text = addInfo.Agility.toString();
               break;
            case 3:
               _valueTxt.text = addInfo.Luck.toString();
               break;
            case 4:
               _valueTxt.text = addInfo.Blood.toString();
               break;
            case 5:
               _valueTxt.text = addInfo.Damage.toString();
               break;
            case 6:
               _valueTxt.text = addInfo.Guard.toString();
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
