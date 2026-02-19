import React, { useState, useEffect } from 'react'
import { supabase } from '../supabaseClient'
import Planning from './Planning'

export default function AdminDashboard() {
  const [equides, setEquides] = useState([])
  const [cavaliers, setCavaliers] = useState([])
  const [moniteurs, setMoniteurs] = useState([])

  useEffect(() => {
    fetchEquides()
    fetchCavaliers()
    fetchMoniteurs()
  }, [])

  async function fetchEquides() {
    const { data, error } = await supabase.from('equides').select('*')
    if (!error) setEquides(data)
  }

  async function fetchCavaliers() {
    const { data, error } = await supabase.from('cavaliers').select('*')
    if (!error) setCavaliers(data)
  }

  async function fetchMoniteurs() {
    const { data, error } = await supabase.from('moniteurs').select('*')
    if (!error) setMoniteurs(data)
  }

  return (
    <div>
      <h2>Planning & Attributions</h2>
      <Planning equides={equides} cavaliers={cavaliers} moniteurs={moniteurs} />
    </div>
  )
}