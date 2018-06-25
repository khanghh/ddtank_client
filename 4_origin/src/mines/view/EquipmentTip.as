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
      
      override public function set tipData(data:Object) : void
      {
         if(data)
         {
            type = data.type;
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
         var i:int = 0;
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
         var listStr:String = "";
         for(i = 0; i < MinesManager.instance.model.equipList.length; )
         {
            listStr = listStr + LanguageMgr.GetTranslation("ddt.mines.equipmentView.lvlabel",i + 1);
            switch(int(type) - 1)
            {
               case 0:
                  listStr = listStr + (String("+" + MinesManager.instance.model.equipList[i].attack));
                  break;
               case 1:
                  listStr = listStr + (String("+" + MinesManager.instance.model.equipList[i].defence));
                  break;
               case 2:
                  listStr = listStr + (String("+" + MinesManager.instance.model.equipList[i].agility));
                  break;
               case 3:
                  listStr = listStr + (String("+" + MinesManager.instance.model.equipList[i].lucky));
            }
            if(i % 2 != 0)
            {
               listStr = listStr + "\n";
            }
            else
            {
               listStr = listStr + "          ";
            }
            i++;
         }
         _propertyListTxt.htmlText = listStr;
         _tipbackgound.width = _line.width;
         _tipbackgound.height = _propertyListTxt.y + _propertyListTxt.height + 10;
      }
   }
}
