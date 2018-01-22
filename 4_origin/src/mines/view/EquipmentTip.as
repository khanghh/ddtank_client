package mines.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.tip.BaseTip;
   import ddt.manager.LanguageMgr;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import mines.MinesManager;
   
   public class EquipmentTip extends BaseTip implements Disposeable
   {
       
      
      private var _line:Image;
      
      private var _nameTxt:FilterFrameText;
      
      private var _myPropertyTxt:FilterFrameText;
      
      private var _propertyListTxt:FilterFrameText;
      
      private var proBit:Bitmap;
      
      private var propertyList:Array;
      
      private var nameList:Array;
      
      private var type:int;
      
      private var level:int;
      
      public function EquipmentTip()
      {
         propertyList = LanguageMgr.GetTranslation("ddt.mines.equipmentView.propertyList").split("|");
         nameList = LanguageMgr.GetTranslation("ddt.mines.equipmentView.nameList").split("|");
         super();
         _tipbackgound = ComponentFactory.Instance.creat("core.GoodsTipBg");
         addChildren();
         _line = ComponentFactory.Instance.creatComponentByStylename("HRuleAsset");
         addChild(_line);
         PositionUtils.setPos(_line,"mines.equipmentView.linePos");
         proBit = ComponentFactory.Instance.creatBitmap("asset.mines.equipmentView.property");
         addChild(proBit);
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("mines.equipmentTip.nameText");
         addChild(_nameTxt);
         _myPropertyTxt = ComponentFactory.Instance.creatComponentByStylename("mines.equipmentTip.myPropertyText");
         addChild(_myPropertyTxt);
         _propertyListTxt = ComponentFactory.Instance.creatComponentByStylename("mines.equipmentTip.propertyListText");
         addChild(_propertyListTxt);
      }
      
      override public function get tipData() : Object
      {
         return _tipData;
      }
      
      override public function set tipData(param1:Object) : void
      {
         if(param1)
         {
            type = param1.type;
            updataTip();
         }
         else
         {
            _tipData = null;
            visible = false;
         }
      }
      
      public function updataTip() : void
      {
         var _loc2_:int = 0;
         _nameTxt.text = nameList[type - 1];
         switch(int(type) - 1)
         {
            case 0:
               _myPropertyTxt.text = propertyList[type - 1] + "+" + MinesManager.instance.model.equipList[MinesManager.instance.model.headLevel - 1].attack;
               break;
            case 1:
               _myPropertyTxt.text = propertyList[type - 1] + "+" + MinesManager.instance.model.equipList[MinesManager.instance.model.clothLevel - 1].defence;
               break;
            case 2:
               _myPropertyTxt.text = propertyList[type - 1] + "+" + MinesManager.instance.model.equipList[MinesManager.instance.model.weaponLevel - 1].agility;
               break;
            case 3:
               _myPropertyTxt.text = propertyList[type - 1] + "+" + MinesManager.instance.model.equipList[MinesManager.instance.model.shieldLevel - 1].lucky;
         }
         var _loc1_:String = "";
         _loc2_ = 0;
         while(_loc2_ < MinesManager.instance.model.equipList.length)
         {
            _loc1_ = _loc1_ + LanguageMgr.GetTranslation("ddt.mines.equipmentView.lvlabel",_loc2_ + 1);
            switch(int(type) - 1)
            {
               case 0:
                  _loc1_ = _loc1_ + (String("+" + MinesManager.instance.model.equipList[_loc2_].attack));
                  break;
               case 1:
                  _loc1_ = _loc1_ + (String("+" + MinesManager.instance.model.equipList[_loc2_].defence));
                  break;
               case 2:
                  _loc1_ = _loc1_ + (String("+" + MinesManager.instance.model.equipList[_loc2_].agility));
                  break;
               case 3:
                  _loc1_ = _loc1_ + (String("+" + MinesManager.instance.model.equipList[_loc2_].lucky));
            }
            if(_loc2_ % 2 != 0)
            {
               _loc1_ = _loc1_ + "\n";
            }
            else
            {
               _loc1_ = _loc1_ + "          ";
            }
            _loc2_++;
         }
         _propertyListTxt.htmlText = _loc1_;
         _tipbackgound.width = _line.width;
         _tipbackgound.height = _propertyListTxt.y + _propertyListTxt.height + 10;
      }
   }
}
