package cityBattle.view
{
   import cityBattle.CityBattleManager;
   import cityBattle.data.WelfareInfo;
   import cityBattle.event.CityBattleEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.box.BoxGoodsTempInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.BossBoxManager;
   import ddt.manager.ItemManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class WelfareView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _myScoreTxt:FilterFrameText;
      
      private var _box:Sprite;
      
      private var _winBtn:MovieClip;
      
      private var _prize:WinnerPrizeView;
      
      public function WelfareView()
      {
         super();
         init();
      }
      
      private function init() : void
      {
         var i:int = 0;
         var winfo:* = null;
         var nowDay:int = 0;
         var fourCell:* = null;
         var sevenCell:* = null;
         _bg = ComponentFactory.Instance.creatBitmap("asset.cityBattle.bg3");
         addChild(_bg);
         _myScoreTxt = ComponentFactory.Instance.creatComponentByStylename("welfare.myscore.txt");
         addChild(_myScoreTxt);
         _myScoreTxt.text = String(CityBattleManager.instance.myScore);
         _winBtn = ClassUtils.CreatInstance("asset.cityBattle.box");
         if(CityBattleManager.instance.now < 8 && CityBattleManager.instance.now > 0)
         {
            addChild(_winBtn);
         }
         PositionUtils.setPos(_winBtn,"welfare.boxPos");
         _winBtn.addEventListener("click",clickHandler);
         _winBtn.addEventListener("mouseOver",overHandler);
         _winBtn.addEventListener("mouseOut",outHandler);
         _box = new Sprite();
         addChild(_box);
         var fourIndex:int = 0;
         var seveIndex:int = 0;
         for(i = 0; i < CityBattleManager.instance.welfareList.length; i++)
         {
            winfo = CityBattleManager.instance.welfareList[i];
            if(winfo.Quality == 2)
            {
               if(CityBattleManager.instance.now < 8 && CityBattleManager.instance.now > 0)
               {
                  nowDay = CityBattleManager.instance.now;
               }
               else
               {
                  nowDay = 7;
               }
               if(winfo.Probability == nowDay)
               {
                  fourCell = new WelfareCell();
                  fourCell.info = winfo;
                  fourCell.x = 94 * fourIndex + 319;
                  fourCell.y = 180;
                  _box.addChild(fourCell);
                  fourIndex++;
                  continue;
               }
            }
            if(winfo.Quality == 3)
            {
               sevenCell = new WelfareCell();
               sevenCell.info = winfo;
               if(seveIndex <= 2)
               {
                  sevenCell.x = 94 * seveIndex + 368;
                  sevenCell.y = 365;
               }
               else
               {
                  sevenCell.x = 94 * (seveIndex - 3) + 318;
                  sevenCell.y = 455;
               }
               _box.addChild(sevenCell);
               seveIndex++;
               continue;
            }
         }
         CityBattleManager.instance.addEventListener("scoreChange",_scoreChange);
      }
      
      private function _scoreChange(e:CityBattleEvent) : void
      {
         _myScoreTxt.text = String(CityBattleManager.instance.myScore);
      }
      
      private function overHandler(e:MouseEvent) : void
      {
         _winBtn.gotoAndStop(2);
      }
      
      private function outHandler(e:MouseEvent) : void
      {
         _winBtn.gotoAndStop(1);
      }
      
      private function clickHandler(e:MouseEvent) : void
      {
         var i:int = 0;
         var winfo:* = null;
         var j:int = 0;
         var binfo:* = null;
         var info:* = null;
         _winBtn.gotoAndStop(1);
         var _arr:Array = [];
         for(i = 0; i < CityBattleManager.instance.welfareList.length; )
         {
            winfo = CityBattleManager.instance.welfareList[i];
            if(winfo.Quality == 5 && winfo.Probability == CityBattleManager.instance.now)
            {
               for(j = 0; j < BossBoxManager.instance.cityBattleTempInfoList[winfo.TemplateID].length; )
               {
                  binfo = BossBoxManager.instance.cityBattleTempInfoList[winfo.TemplateID][j];
                  info = ItemManager.fillByID(binfo.TemplateId);
                  info.IsBinds = binfo.IsBind;
                  info.LuckCompose = binfo.LuckCompose;
                  info.DefendCompose = binfo.DefendCompose;
                  info.AttackCompose = binfo.AttackCompose;
                  info.AgilityCompose = binfo.AgilityCompose;
                  info.StrengthenLevel = binfo.StrengthenLevel;
                  info.ValidDate = binfo.ItemValid;
                  info.Count = binfo.ItemCount;
                  _arr.push(info);
                  j++;
               }
            }
            i++;
         }
         _prize = ComponentFactory.Instance.creat("welfare.winnerPrizeView");
         _prize.goodsList = _arr;
         LayerManager.Instance.addToLayer(_prize,3,true,1);
      }
      
      public function dispose() : void
      {
         CityBattleManager.instance.removeEventListener("scoreChange",_scoreChange);
         _winBtn.removeEventListener("click",clickHandler);
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_myScoreTxt);
         _myScoreTxt = null;
         ObjectUtils.disposeObject(_box);
         _box = null;
         ObjectUtils.disposeObject(_winBtn);
         _winBtn = null;
      }
   }
}
