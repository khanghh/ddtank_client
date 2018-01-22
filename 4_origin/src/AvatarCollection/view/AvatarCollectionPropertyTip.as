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
         var _loc3_:int = 0;
         var _loc2_:* = null;
         var _loc1_:* = null;
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
         var _loc4_:Array = LanguageMgr.GetTranslation("avatarCollection.propertyNameTxt").split(",");
         _loc3_ = 0;
         while(_loc3_ < 7)
         {
            _loc2_ = ComponentFactory.Instance.creatComponentByStylename("avatarColl.propertyTip.nameTxt");
            _loc2_.text = _loc4_[_loc3_] + "：";
            _loc2_.x = 15;
            _loc2_.y = _loc3_ * 20 + 46;
            addChild(_loc2_);
            _loc1_ = ComponentFactory.Instance.creatComponentByStylename("avatarColl.propertyTip.valueTxt");
            _loc1_.text = "0";
            _loc1_.x = 103;
            _loc1_.y = _loc3_ * 20 + 46;
            addChild(_loc1_);
            _valueTxtList.push(_loc1_);
            _loc3_++;
         }
      }
      
      public function refreshView(param1:AvatarCollectionUnitVo, param2:int) : void
      {
         _valueTxtList[0].text = (param1.Attack * param2).toString();
         _valueTxtList[1].text = (param1.Defence * param2).toString();
         _valueTxtList[2].text = (param1.Agility * param2).toString();
         _valueTxtList[3].text = (param1.Luck * param2).toString();
         _valueTxtList[4].text = (param1.Damage * param2).toString();
         _valueTxtList[5].text = (param1.Guard * param2).toString();
         _valueTxtList[6].text = (param1.Blood * param2).toString();
         _titleTxt.text = _titleStrList[param2 - 1];
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
