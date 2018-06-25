package AvatarCollection.view
{
   import AvatarCollection.data.AvatarCollectionUnitVo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import flash.display.Sprite;
   
   public class AvatarCollectionPropertyTip extends Sprite implements Disposeable
   {
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _line:ScaleBitmapImage;
      
      private var _titleTxt:FilterFrameText;
      
      private var _valueTxtList:Vector.<FilterFrameText>;
      
      private var _titleStrList:Array;
      
      public function AvatarCollectionPropertyTip()
      {
         var i:int = 0;
         var nameTxt:* = null;
         var valueTxt:* = null;
         super();
         _bg = ComponentFactory.Instance.creatComponentByStylename("core.GoodsTipBg");
         _bg.width = 230;
         _bg.height = 205;
         addChild(_bg);
         _line = ComponentFactory.Instance.creatComponentByStylename("HRuleAsset");
         _line.width = 220;
         _line.x = 4;
         _line.y = 36;
         addChild(_line);
         _titleStrList = LanguageMgr.GetTranslation("avatarCollection.propertyTipTitleTxt").split(",");
         _titleTxt = ComponentFactory.Instance.creatComponentByStylename("avatarColl.propertyTip.titleTxt");
         addChild(_titleTxt);
         _valueTxtList = new Vector.<FilterFrameText>();
         var nameStrList:Array = LanguageMgr.GetTranslation("avatarCollection.propertyNameTxt").split(",");
         for(i = 0; i < 7; )
         {
            nameTxt = ComponentFactory.Instance.creatComponentByStylename("avatarColl.propertyTip.nameTxt");
            nameTxt.text = nameStrList[i] + "：";
            nameTxt.x = 15;
            nameTxt.y = i * 20 + 46;
            addChild(nameTxt);
            valueTxt = ComponentFactory.Instance.creatComponentByStylename("avatarColl.propertyTip.valueTxt");
            valueTxt.text = "0";
            valueTxt.x = 103;
            valueTxt.y = i * 20 + 46;
            addChild(valueTxt);
            _valueTxtList.push(valueTxt);
            i++;
         }
      }
      
      public function refreshView(data:AvatarCollectionUnitVo, completeStatus:int) : void
      {
         _valueTxtList[0].text = (data.Attack * completeStatus).toString();
         _valueTxtList[1].text = (data.Defence * completeStatus).toString();
         _valueTxtList[2].text = (data.Agility * completeStatus).toString();
         _valueTxtList[3].text = (data.Luck * completeStatus).toString();
         _valueTxtList[4].text = (data.Damage * completeStatus).toString();
         _valueTxtList[5].text = (data.Guard * completeStatus).toString();
         _valueTxtList[6].text = (data.Blood * completeStatus).toString();
         _titleTxt.text = _titleStrList[completeStatus - 1];
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
         _bg = null;
         _line = null;
         _titleTxt = null;
         _valueTxtList = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
