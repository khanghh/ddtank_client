package gemstone.items
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.tip.BaseTip;
   import ddt.manager.LanguageMgr;
   import ddt.view.SimpleItem;
   import flash.display.DisplayObject;
   import gemstone.info.GemstoneStaticInfo;
   
   public class GemstoneTip extends BaseTip
   {
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _tempData:Object;
      
      private var _fiSoulName:FilterFrameText;
      
      private var _quality:SimpleItem;
      
      private var _type:SimpleItem;
      
      private var _attack:FilterFrameText;
      
      private var _defense:FilterFrameText;
      
      private var _agility:FilterFrameText;
      
      private var _luck:FilterFrameText;
      
      private var _grade1:FilterFrameText;
      
      private var _grade2:FilterFrameText;
      
      private var _grade3:FilterFrameText;
      
      private var _forever:FilterFrameText;
      
      private var _displayList:Vector.<DisplayObject>;
      
      public function GemstoneTip()
      {
         super();
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
      }
      
      override public function set tipData(param1:Object) : void
      {
         _tempData = param1;
         if(!_tempData)
         {
            return;
         }
         _displayList = new Vector.<DisplayObject>();
         updateView();
      }
      
      private function clear() : void
      {
         var _loc1_:* = null;
         while(numChildren > 0)
         {
            _loc1_ = getChildAt(0) as DisplayObject;
            if(_loc1_.parent)
            {
               _loc1_.parent.removeChild(_loc1_);
            }
         }
      }
      
      private function updateView() : void
      {
         var _loc6_:* = null;
         var _loc4_:* = null;
         var _loc2_:* = null;
         var _loc8_:int = 0;
         clear();
         _bg = ComponentFactory.Instance.creat("core.GoodsTipBg");
         _bg.width = 300;
         _bg.height = 200;
         this.tipbackgound = _bg;
         _fiSoulName = ComponentFactory.Instance.creatComponentByStylename("core.GoodsTipItemNameTxt");
         _displayList.push(_fiSoulName);
         var _loc7_:Vector.<GemstoneStaticInfo> = _tempData as Vector.<GemstoneStaticInfo>;
         var _loc3_:int = _loc7_.length;
         var _loc5_:String = LanguageMgr.GetTranslation("ddt.gemstone.curInfo.GoldenAddAttack");
         var _loc1_:String = LanguageMgr.GetTranslation("ddt.gemstone.curInfo.GoldenReduceDamage");
         _loc8_ = 0;
         while(_loc8_ < _loc3_)
         {
            if(_loc7_[_loc8_].attack != 0)
            {
               _loc2_ = {};
               _loc2_.id = _loc7_[_loc8_].id;
               if(_loc7_[_loc8_].level == 6)
               {
                  _loc2_.str = LanguageMgr.GetTranslation("ddt.gemstone.curInfo.goldenGemstoneAtc",String(_loc7_[_loc8_].attack) + _loc5_);
               }
               else
               {
                  _loc2_.str = LanguageMgr.GetTranslation("ddt.gemstone.curInfo.redGemstoneAtc",_loc7_[_loc8_].level,String(_loc7_[_loc8_].attack));
               }
               _fiSoulName.text = LanguageMgr.GetTranslation("ddt.gemstone.curInfo.redGemstone");
               _loc4_ = new GemstonTipItem();
               _loc4_.setInfo(_loc2_);
               _displayList.push(_loc4_);
            }
            else if(_loc7_[_loc8_].defence != 0)
            {
               _fiSoulName.text = LanguageMgr.GetTranslation("ddt.gemstone.curInfo.bluGemstone");
               _loc2_ = {};
               _loc2_.id = _loc7_[_loc8_].id;
               if(_loc7_[_loc8_].level == 6)
               {
                  _loc2_.str = LanguageMgr.GetTranslation("ddt.gemstone.curInfo.goldenGemstoneDef",String(_loc7_[_loc8_].defence) + _loc1_);
               }
               else
               {
                  _loc2_.str = LanguageMgr.GetTranslation("ddt.gemstone.curInfo.bluGemstoneDef",_loc7_[_loc8_].level,String(_loc7_[_loc8_].defence));
               }
               _loc4_ = new GemstonTipItem();
               _loc4_.setInfo(_loc2_);
               _displayList.push(_loc4_);
            }
            else if(_loc7_[_loc8_].agility != 0)
            {
               _fiSoulName.text = LanguageMgr.GetTranslation("ddt.gemstone.curInfo.gesGemstone");
               _loc2_ = {};
               _loc2_.id = _loc7_[_loc8_].id;
               if(_loc7_[_loc8_].level == 6)
               {
                  _loc2_.str = LanguageMgr.GetTranslation("ddt.gemstone.curInfo.goldenGemstoneAgi",String(_loc7_[_loc8_].agility) + _loc5_);
               }
               else
               {
                  _loc2_.str = LanguageMgr.GetTranslation("ddt.gemstone.curInfo.gesGemstoneAgi",_loc7_[_loc8_].level,String(_loc7_[_loc8_].agility));
               }
               _loc4_ = new GemstonTipItem();
               _loc4_.setInfo(_loc2_);
               _displayList.push(_loc4_);
            }
            else if(_loc7_[_loc8_].luck != 0)
            {
               _fiSoulName.text = LanguageMgr.GetTranslation("ddt.gemstone.curInfo.yelGemstone");
               _loc2_ = {};
               _loc2_.id = _loc7_[_loc8_].id;
               if(_loc7_[_loc8_].level == 6)
               {
                  _loc2_.str = LanguageMgr.GetTranslation("ddt.gemstone.curInfo.goldenGemstoneLuk",String(_loc7_[_loc8_].luck) + _loc1_);
               }
               else
               {
                  _loc2_.str = LanguageMgr.GetTranslation("ddt.gemstone.curInfo.yelGemstoneLuk",_loc7_[_loc8_].level,String(_loc7_[_loc8_].luck));
               }
               _loc4_ = new GemstonTipItem();
               _loc4_.setInfo(_loc2_);
               _displayList.push(_loc4_);
            }
            else if(_loc7_[_loc8_].blood != 0)
            {
               _fiSoulName.text = LanguageMgr.GetTranslation("ddt.gemstone.curInfo.purpleGemstone");
               _loc2_ = {};
               _loc2_.id = _loc7_[_loc8_].id;
               if(_loc7_[_loc8_].level == 6)
               {
                  _loc2_.str = LanguageMgr.GetTranslation("ddt.gemstone.curInfo.goldenGemstoneHp",String(_loc7_[_loc8_].blood) + _loc1_);
               }
               else
               {
                  _loc2_.str = LanguageMgr.GetTranslation("ddt.gemstone.curInfo.purpleGemstoneLuk",_loc7_[_loc8_].level,String(_loc7_[_loc8_].blood));
               }
               _loc4_ = new GemstonTipItem();
               _loc4_.setInfo(_loc2_);
               _displayList.push(_loc4_);
            }
            _loc8_++;
         }
         initPos();
      }
      
      override public function get tipData() : Object
      {
         return _tempData;
      }
      
      override protected function init() : void
      {
      }
      
      private function initPos() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = _displayList.length;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _displayList[_loc2_].y = _loc2_ * 28 + 5;
            _displayList[_loc2_].x = 5;
            addChild(_displayList[_loc2_] as DisplayObject);
            _loc2_++;
         }
         if(_displayList.length > 0)
         {
            _bg.height = _displayList[_displayList.length - 1].y + 40;
         }
         else
         {
            _bg.height = 40;
         }
      }
   }
}
