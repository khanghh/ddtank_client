package AvatarCollection.view
{
   import AvatarCollection.data.AvatarCollectionUnitVo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.utils.PositionUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import road7th.data.DictionaryData;
   
   public class AvatarCollectionPropertyCell extends Sprite implements Disposeable
   {
       
      
      private var _bg:MovieClip;
      
      private var _nameTxt:FilterFrameText;
      
      private var _valueTxt:FilterFrameText;
      
      private var _index:int;
      
      public function AvatarCollectionPropertyCell(index:int)
      {
         super();
         _index = index;
         _bg = ComponentFactory.Instance.creat("asset.avatarColl.propertyBg");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("avatarColl.propertyCell.nameTxt");
         var tmp:Array = LanguageMgr.GetTranslation("avatarCollection.propertyNameTxt").split(",");
         _nameTxt.text = tmp[_index];
         _valueTxt = ComponentFactory.Instance.creatComponentByStylename("avatarColl.propertyCell.valueTxt");
         _valueTxt.text = "0";
         PositionUtils.setPos(_bg,_valueTxt);
         addChild(_bg);
         addChild(_nameTxt);
         addChild(_valueTxt);
      }
      
      public function refreshView(data:AvatarCollectionUnitVo, completeStatus:int) : void
      {
         if(completeStatus == -1)
         {
            _valueTxt.text = "";
            return;
         }
         if(completeStatus == 0)
         {
            _valueTxt.text = "0";
            return;
         }
         var tmpValue:int = 0;
         switch(int(_index))
         {
            case 0:
               tmpValue = data.Attack;
               break;
            case 1:
               tmpValue = data.Defence;
               break;
            case 2:
               tmpValue = data.Agility;
               break;
            case 3:
               tmpValue = data.Luck;
               break;
            case 4:
               tmpValue = data.Damage;
               break;
            case 5:
               tmpValue = data.Guard;
               break;
            case 6:
               tmpValue = data.Blood;
         }
         var value:int = completeStatus == 2?tmpValue * 2:tmpValue;
         _valueTxt.text = value.toString();
      }
      
      public function refreshAllProperty(data:AvatarCollectionUnitVo) : void
      {
         var tmpValue:int = 0;
         switch(int(_index))
         {
            case 0:
               tmpValue = data.Attack;
               break;
            case 1:
               tmpValue = data.Defence;
               break;
            case 2:
               tmpValue = data.Agility;
               break;
            case 3:
               tmpValue = data.Luck;
               break;
            case 4:
               tmpValue = data.Damage;
               break;
            case 5:
               tmpValue = data.Guard;
               break;
            case 6:
               tmpValue = data.Blood;
         }
         var playerPropArr:Array = ["Attack","Defence","Agility","Luck","Damage","Armor","HP"];
         var dic:DictionaryData = PlayerManager.Instance.Self.getPropertyAdditionByType(playerPropArr[_index]);
         _valueTxt.text = (!!dic?dic["Avatar"]:0) + "/" + tmpValue.toString();
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
         _bg = null;
         _nameTxt = null;
         _valueTxt = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
