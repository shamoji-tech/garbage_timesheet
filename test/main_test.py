import unittest
from unittest.mock import MagicMock
import sys
sys.modules['dao'] = MagicMock()
sys.modules['dao.dao'] = MagicMock()

import datetime
from src.main import is2nd4thFriday

class TestMainFunction(unittest.TestCase):


    def test_is2nd4thFriday(self):
        self.assertEqual(is2nd4thFriday(datetime.date(2020,6,11)),False)
        self.assertEqual(is2nd4thFriday(datetime.date(2020,6,12)),True)
        self.assertEqual(is2nd4thFriday(datetime.date(2020,6,13)),False)
        self.assertEqual(is2nd4thFriday(datetime.date(2020,6,26)),True)

        